//
//  ResourcesDataServiceProtocol.swift
//
//
//  Created by Kristian Mitra on 2/17/24.
//

import Foundation
import DigitalAPIClient

public protocol ResourcesGraphDataServiceProtocol {
    
    // MARK: - Methods
    
    func getStationsAsync() async -> [Components.Schemas.Station]
    
    func getCitiesAsync() async -> [DigitalAPIClient.Components.Schemas.City]
    
    func getMarketsv2Async() async -> [DigitalAPIClient.Components.Schemas.Marketv2]
    
    func getCountriesv2Async() async -> [DigitalAPIClient.Components.Schemas.Countryv2]
}
