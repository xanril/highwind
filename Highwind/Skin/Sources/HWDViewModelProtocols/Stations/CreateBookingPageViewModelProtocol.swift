//
//  StationsPageViewModelProtocol.swift
//
//
//  Created by Kristian Mitra on 2/18/24.
//

import Foundation
import DigitalAPIClient

public protocol CreateBookingPageViewModelProtocol {
    
    // MARK: - Properties
    
    var originStations: [Components.Schemas.Station] { get }
    var destinationStations: [Components.Schemas.Station] { get }
    var selectedOrigin: String { get set }
    var selectedDestination: String { get set }
    var selectedDate: Date { get set }
    var adultCount: Int32 { get set }
    
    // MARK: - Methods
    func initializeAsync() async
    func fetchDataAsync() async
    func updateOriginStations()
    func updateDestinationStations()
    func searchForFlightsAsync() async
}
