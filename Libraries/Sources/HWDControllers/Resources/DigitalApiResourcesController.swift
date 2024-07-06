//
//  DigitalApiResourcesController.swift
//
//
//  Created by Kristian Mitra on 2/17/24.
//

import HWDControllerProtocols
import HWDDataServiceProtocols
import DigitalAPIClient

public struct DigitalApiResourcesController: DigitalApiResourcesControllerProtocol {
    
    // MARK: - Fields
    
    private var resourcesGraphDataService: ResourcesGraphDataServiceProtocol
    
    // MARK: - Constructor
    
    public init(resourcesGraphDataService: ResourcesGraphDataServiceProtocol?) {
        guard let _ = resourcesGraphDataService else { fatalError() }
        self.resourcesGraphDataService = resourcesGraphDataService!
    }
    
    // MARK: - Methods
    
    public func getStationsStatelessAsync() async -> [Components.Schemas.Station] {
        return await resourcesGraphDataService.getStationsAsync()
    }
    
    public func getMarktesv2StatelessAsync() async -> [Components.Schemas.Marketv2] {
        return await resourcesGraphDataService.getMarketsv2Async()
    }
    
    public func getCitiesStatelessAsync() async -> [Components.Schemas.City] {
        return await resourcesGraphDataService.getCitiesAsync()
    }
    
    public func getCountriesv2StatelessAsync() async -> [Components.Schemas.Countryv2] {
        return await resourcesGraphDataService.getCountriesv2Async()
    }
}
