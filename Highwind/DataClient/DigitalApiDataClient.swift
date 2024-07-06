//
//  DigitalApiDataClient.swift
//
//
//  Created by Kristian Mitra on 2/9/24.
//

import Foundation
import DigitalAPIClient
import OpenAPIRuntime
import OpenAPIURLSession
import HWDDataServiceProtocols

public class DigitalApiDataClient: DataClientProtocol {
    
    // MARK: - Fields
    
    private var mobileConfiguration: MobileConfigurationProtocol
    private var requestHandlers: [RequestHandlerProtocol] = []
    
    // MARK: - Initializers
    
    public init(mobileConfiguration: MobileConfigurationProtocol?, requestHandlers: [RequestHandlerProtocol]) {
        guard let _ = mobileConfiguration else { fatalError() }
        
        self.mobileConfiguration = mobileConfiguration!
        self.requestHandlers = requestHandlers
    }
    
    // MARK: - Methods
    
    public func getClientAsync() async -> APIProtocol {
        var middlewares: [ClientMiddleware] = []

        await withTaskGroup(of: ClientMiddleware?.self, body: { group in
            for handler in requestHandlers {
                group.addTask {
                    async let middleware = handler.getMiddlewareAsync()
                    return await middleware
                }
            }
            
            for await middleware in group {
                guard (middleware != nil) else {
                    continue
                }
                
                middlewares.append(middleware!)
            }
        })
        
        return Client(
            serverURL: URL(string: mobileConfiguration.defaultBaseUrl)!,
            transport: URLSessionTransport(),
            middlewares: middlewares)
    }
}
