//
//  FlightSelectPageViewModel.swift
//
//
//  Created by Kristian Mitra on 2/25/24.
//

import Foundation
import DigitalAPIClient
import HWDControllerProtocols
import HWDViewModelProtocols

@Observable
public class FlightSelectPageViewModel: FlightSelectPageViewModelProtocol {
    
    // MARK: - Fields
    
    private var searchController: SearchControllerProtocol
    private var pageParameters: FlightSelectPageParameters = FlightSelectPageParameters()
    
    // MARK: - Properties
    public var availableFlights: [FlightAvailabilityModel] = []
    
    // MARK: - Constructors
    
    public init(searchController: SearchControllerProtocol?) {
        guard let _ = searchController else { fatalError() }
        self.searchController = searchController!
    }
    
    // MARK: - Methods
    
    public func initializeAsync(pageParams: FlightSelectPageParameters) async {
        self.pageParameters = pageParams
        await searchForFlightsAsync()
    }
    
    private func searchForFlightsAsync() async {
        
        let passengerTypeCriteria = Components.Schemas.PassengerTypeCriteria(
            types: [Components.Schemas.PassengerSearchCriteria(_type: "ADT", count: pageParameters.adultCount)])
        
        let request = Components.Schemas.AvailabilitySimpleRequestv2(
            origin: pageParameters.selectedOrigin,
            destination: pageParameters.selectedDestination,
            beginDate: pageParameters.selectedDate,
            endDate: Calendar.current.date(byAdding: .day, value: 1, to: pageParameters.selectedDate)!,
            passengers: passengerTypeCriteria)
        
        let response = await searchController.searchSimpleAsync(availabilitySimpleRequest: request)
        let firstTripResult = response.results?.first?.trips ?? [Components.Schemas.TripDateMarket]()
        let faresAvailable = response.faresAvailable ?? Components.Schemas.Availabilityv2.faresAvailablePayload()
        
        let marketKey = "\(self.pageParameters.selectedOrigin)|\(self.pageParameters.selectedDestination)"
        let journeys = firstTripResult.first?.journeysAvailableByMarket?.additionalProperties[marketKey]
            ?? [Components.Schemas.AvailableJourney]()
        
        availableFlights = convertToModels(availableJourneys: journeys, faresAvailable: faresAvailable)
    }
    
    private func convertToModels(
        availableJourneys: [Components.Schemas.AvailableJourney],
        faresAvailable: Components.Schemas.Availabilityv2.faresAvailablePayload) -> [FlightAvailabilityModel] {
        
        var results = [FlightAvailabilityModel]()
            
        // for each journey, look up the fare and create a view model object
        for journey in availableJourneys {
            let journeyFare = journey.fares?.first
            let fareReference = faresAvailable.additionalProperties[journeyFare?.fareAvailabilityKey ?? ""]
            
            if (fareReference == nil) {
                continue
            }
            
            results.append(FlightAvailabilityModel(journey: journey, fareReference: fareReference!))
        }
        
        return results
    }
}
