//
//  SearchControllerProtocol.swift
//
//
//  Created by Kristian Mitra on 2/19/24.
//

import DigitalAPIClient

public protocol SearchControllerProtocol {
    
    // MARK: - Methods
    func searchSimpleAsync(availabilitySimpleRequest: Components.Schemas.AvailabilitySimpleRequestv2) async -> Components.Schemas.Availabilityv2
}
