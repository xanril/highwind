//
//  File.swift
//  
//
//  Created by Kristian Mitra on 2/19/24.
//

import DigitalAPIClient

public protocol SearchSimpleDataServiceProtocol {
    
    // MARK: - Methods
    func postAsync(availabilitySimpleRequest: Components.Schemas.AvailabilitySimpleRequestv2) async -> Components.Schemas.IJsonResponseOfAvailabilityv2?
}
