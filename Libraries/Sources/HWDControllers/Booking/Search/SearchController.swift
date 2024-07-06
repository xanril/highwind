//
//  SearchController.swift
//
//
//  Created by Kristian Mitra on 2/19/24.
//

import DigitalAPIClient
import HWDControllerProtocols
import HWDDataServiceProtocols

public struct SearchController: SearchControllerProtocol {
    
    // MARK: - Fields
    
    private var searchDataService: SearchSimpleDataServiceProtocol
    
    // MARK: - Constructor
    
    public init(searchDataService: SearchSimpleDataServiceProtocol?) {
        guard let _ = searchDataService else { fatalError() }
        self.searchDataService = searchDataService!
    }
    
    // MARK: - Methods
    
    public func searchSimpleAsync(availabilitySimpleRequest: Components.Schemas.AvailabilitySimpleRequestv2) async -> Components.Schemas.Availabilityv2 {
        
        let response = await searchDataService.postAsync(availabilitySimpleRequest: availabilitySimpleRequest)
        return response?.data ?? Components.Schemas.Availabilityv2()
    }
}
