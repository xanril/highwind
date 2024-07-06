//
//  MobileConfiguration.swift
//  Highwind
//
//  Created by Kristian Mitra on 2/9/24.
//

import Foundation
import HWDDataServiceProtocols

public struct MobileConfiguration: MobileConfigurationProtocol {
    
    // MARK: - Properties
    
    public var tokenApplicationName: String = "Mobile"
    public var defaultBaseUrl: String = "__DEFAULT_BASE_URL__"
    public var defaultGatewaySubscriptionKey: String = "__SUBSCRIPTION_KEY__"
    public var defaultGatewaySubscriptionValue: String = "__SUBSRIPTION_VALUE__"
    
    // MARK: - Constructor
    public init() {
        if let path = Bundle.main.path(forResource: "MobileConfiguration", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: path),
           let customConfig = try? PropertyListSerialization
            .propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String: Any] {
            
            defaultBaseUrl = customConfig["DEFAULT_BASE_URL"] as? String ?? defaultBaseUrl
            defaultGatewaySubscriptionKey = customConfig["DEFAULT_GATEWAY_SUBSCRIPTION_KEY"] as? String ?? defaultGatewaySubscriptionKey
            defaultGatewaySubscriptionValue = customConfig["DEFAULT_GATEWAY_SUBSCRIPTION_VALUE"] as? String ?? defaultGatewaySubscriptionValue
        }
        else {
            fatalError("Error reading MobileConfiguration")
        }
    }
}
