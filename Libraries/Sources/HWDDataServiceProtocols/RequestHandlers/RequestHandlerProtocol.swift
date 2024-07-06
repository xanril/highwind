//
//  RequestHandlerProtocol.swift
//
//
//  Created by Kristian Mitra on 2/9/24.
//

import OpenAPIRuntime

public protocol RequestHandlerProtocol {
    
    func getMiddlewareAsync() async -> ClientMiddleware?
}
