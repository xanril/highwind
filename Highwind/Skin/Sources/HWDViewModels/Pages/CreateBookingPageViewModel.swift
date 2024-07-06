//
//  BookingPageViewModel.swift
//
//
//  Created by Kristian Mitra on 2/18/24.
//

import Foundation
import HWDControllerProtocols
import HWDViewModelProtocols
import DigitalAPIClient

@Observable
public class CreateBookingPageViewModel: CreateBookingPageViewModelProtocol {
    
    // MARK: - Fields
    private var digitalApiResourcesController: DigitalApiResourcesControllerProtocol
    private var searchController: SearchControllerProtocol
    
    private var stationsData: [Components.Schemas.Station] = []
    private var marketsData: [Components.Schemas.Marketv2] = []
    
    // MARK: - Properties
    
    public var originStations: [Components.Schemas.Station] = []
    public var destinationStations: [Components.Schemas.Station] = []
    public var selectedOrigin: String = ""
    public var selectedDestination: String = ""
    public var selectedDate: Date = Date.now
    public var adultCount: Int32 = 1
    
    // MARK: - Constructor
    
    public init(digitalApiResourcesController: DigitalApiResourcesControllerProtocol?,
                searchController: SearchControllerProtocol?) {
        guard let _ = digitalApiResourcesController else { fatalError() }
        guard let _ = searchController else { fatalError() }
        
        self.digitalApiResourcesController = digitalApiResourcesController!
        self.searchController = searchController!
    }
    
    // MARK: - Methods
    
    public func initializeAsync() async {

        await fetchDataAsync()
        
        updateOriginStations()
        selectedOrigin = originStations.first?.stationCode ?? ""
        
        updateDestinationStations()
        selectedDestination = destinationStations.first?.stationCode ?? ""
    }

    public func fetchDataAsync() async {
        stationsData = await digitalApiResourcesController.getStationsStatelessAsync()
        marketsData = await digitalApiResourcesController.getMarktesv2StatelessAsync()
    }
    
    public func updateOriginStations() {
        // if we dont have a selected destination yet, we show all stations
        if selectedDestination == "" {
            originStations = stationsData.filter { station in
                let hasMarket = marketsData.contains { market in
                    market.travelLocationCode == station.stationCode
                }
                
                return hasMarket && station.stationCode != selectedDestination
            }
        }
        // if we already have a selected destination yet,
        // we filter stations based on market availability
        else {
            originStations = filterStationsByMarkets(
                fromStationCode: selectedDestination,
                excludedStations: [selectedDestination])
        }
    }
    
    public func updateDestinationStations() {
        // if we dont have a selected destination yet, we show all stations
        if selectedOrigin == "" {
            destinationStations = stationsData.filter { station in
                station.stationCode != selectedOrigin
                && station.stationCode != selectedDestination
            }
        }
        else {
            destinationStations = filterStationsByMarkets(
                fromStationCode: selectedOrigin,
                excludedStations: [selectedOrigin])
        }
        
        // check if the selected destination is part of the new set of destination stations
        let isSelectable = destinationStations.contains { item in
            item.stationCode == selectedDestination
        }
        
        // if it is missing, we assign an empty value
        selectedDestination = isSelectable
            ? selectedDestination
            : destinationStations.first?.stationCode ?? ""
    }
    
    public func searchForFlightsAsync() async {
        
        let passengerTypeCriteria = Components.Schemas.PassengerTypeCriteria(
            types: [Components.Schemas.PassengerSearchCriteria(_type: "ADT", count: adultCount)])
        
        let request = Components.Schemas.AvailabilitySimpleRequestv2(
            origin: selectedOrigin,
            destination: selectedDestination,
            beginDate: selectedDate,
            endDate: Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!,
            passengers: passengerTypeCriteria)
        
        let results = await searchController.searchSimpleAsync(availabilitySimpleRequest: request)
        print(results)
    }
    
    private func filterStationsByMarkets(fromStationCode: String, excludedStations: [String]) -> [Components.Schemas.Station] {
        var results: [Components.Schemas.Station] = []
        
        if fromStationCode != "" {
            results = stationsData.filter { station in
                let hasMarket = marketsData.contains { market in
                    market.travelLocationCode == station.stationCode && market.locationCode == fromStationCode
                }
                
                return hasMarket && !excludedStations.contains(station.stationCode)
            }
        }
        else {
            results = stationsData.filter { station in
                let hasMarket = marketsData.contains { market in
                    market.travelLocationCode == station.stationCode
                }
                
                return hasMarket && !excludedStations.contains(station.stationCode)
            }
        }
        
        return results
    }
}
