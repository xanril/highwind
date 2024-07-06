//
//  HttpAzureApiKeyHandler.swift
//  Highwind
//
//  Created by Kristian Mitra on 2/9/24.
//

import Foundation
import OpenAPIRuntime
import HWDDataServiceProtocols
import DigitalAPIClient

public struct HttpAzureApiKeyHandler: RequestHandlerProtocol {
    
    // MARK: - Fields
    
    private let mobileConfiguration: MobileConfigurationProtocol
    
    // MARK: - Initializers
    
    public init(mobileConfiguration: MobileConfigurationProtocol?) {
        guard let _ = mobileConfiguration else { fatalError() }
        self.mobileConfiguration = mobileConfiguration!
    }
    
    // MARK: - Methods
    
    public func getMiddlewareAsync() async -> ClientMiddleware? {
        return ApiKeyMiddleware(
            apiKeyHeaderFieldName: self.mobileConfiguration.defaultGatewaySubscriptionKey,
            apiKeyHeaderFieldValue: self.mobileConfiguration.defaultGatewaySubscriptionValue)
    }
}
