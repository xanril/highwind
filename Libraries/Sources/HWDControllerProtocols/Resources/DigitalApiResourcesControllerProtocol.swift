//
//  DigitalApiResourcesControllerProtocol.swift
//
//
//  Created by Kristian Mitra on 2/18/24.
//

import DigitalAPIClient

public protocol DigitalApiResourcesControllerProtocol {
    
    // MARK: Methods
    
    func getStationsStatelessAsync() async -> [Components.Schemas.Station]
    
    func getMarktesv2StatelessAsync() async -> [Components.Schemas.Marketv2]
    
    func getCitiesStatelessAsync() async -> [Components.Schemas.City]
    
    func getCountriesv2StatelessAsync() async -> [Components.Schemas.Countryv2]
}
