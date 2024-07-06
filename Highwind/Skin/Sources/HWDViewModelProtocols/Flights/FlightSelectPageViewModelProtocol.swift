//
//  FlightSelectPageViewModelProtocol.swift
//
//
//  Created by Kristian Mitra on 2/25/24.
//

import Foundation
import DigitalAPIClient
import HWDControllerProtocols

public protocol FlightSelectPageViewModelProtocol {
    
    // MARK: - Properties
    var availableFlights: [FlightAvailabilityModel] { get }
    
    // MARK: - Methods
    func initializeAsync(pageParams: FlightSelectPageParameters) async
}
