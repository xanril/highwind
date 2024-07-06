//
//  SearchSimpleDataService.swift
//
//
//  Created by Kristian Mitra on 2/19/24.
//

import DigitalAPIClient
import HWDDataServiceProtocols

public struct SearchSimpleDataService: SearchSimpleDataServiceProtocol {
    
    // MARK: - Fields
    
    private let dataClient: DataClientProtocol
    
    // MARK: - Constructor
    
    public init(dataClient: DataClientProtocol?) {
        guard let _ = dataClient else { fatalError() }
        self.dataClient = dataClient!
    }
    
    public func postAsync(availabilitySimpleRequest: Components.Schemas.AvailabilitySimpleRequestv2) async -> Components.Schemas.IJsonResponseOfAvailabilityv2? {
        do
        {
            let client = await dataClient.getClientAsync()

            let results = try await client.nsk_v4_availability_search_simple_post(body: .json(availabilitySimpleRequest))
            return try results.ok.body.json
        }
        catch {
            print(error)
        }
        
        return nil
    }
}
