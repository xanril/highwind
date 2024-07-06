//
//  DataClientProtocol.swift
//
//
//  Created by Kristian Mitra on 2/9/24.
//

import DigitalAPIClient

public protocol DataClientProtocol {
    
    func getClientAsync() async -> APIProtocol
}
