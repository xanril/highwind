//
//  MobileConfigurationProtocol.swift
//
//
//  Created by Kristian Mitra on 2/9/24.
//

import Foundation

public protocol MobileConfigurationProtocol {
    
    var tokenApplicationName: String { get }
    var defaultBaseUrl: String { get }
    var defaultGatewaySubscriptionKey: String  { get }
    var defaultGatewaySubscriptionValue: String  { get }
}
