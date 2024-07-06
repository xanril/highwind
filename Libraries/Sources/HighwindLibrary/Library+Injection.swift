//
//  Library+Injection.swift
//
//
//  Created by Kristian Mitra on 4/29/24.
//

import Factory
import HWDControllerProtocols
import HWDControllers
import HWDDataServiceProtocols
import HWDDataServices

extension Container {
    
    // MARK: Data Services
    
    public var mobileConfiguration: Factory<MobileConfigurationProtocol?> {
        self { fatalError("No registered instance in Factory") }
            .singleton
    }
    
    public var digialApiDataClient: Factory<DataClientProtocol?> {
        self { fatalError("No registered instance in Factory") }
    }
    
    public var resourcesGraphDataService: Factory<ResourcesGraphDataServiceProtocol?> {
        self { ResourcesGraphDataService(dataClient: self.digialApiDataClient()) }
    }
    
    public var searchSimpleDataService: Factory<SearchSimpleDataServiceProtocol?> {
        self { SearchSimpleDataService(dataClient: self.digialApiDataClient()) }
    }
    
    // MARK: Controllers
    
    public var digitalApiResourcesController: Factory<DigitalApiResourcesControllerProtocol?> {
        self { DigitalApiResourcesController(resourcesGraphDataService: self.resourcesGraphDataService()) }
    }
    
    public var searchController: Factory<SearchController?> {
        self { SearchController(searchDataService: self.searchSimpleDataService()) }
    }
}
