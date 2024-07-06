//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftOpenAPIGenerator open source project
//
// Copyright (c) 2023 Apple Inc. and the SwiftOpenAPIGenerator project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftOpenAPIGenerator project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//
import OpenAPIRuntime
import Foundation
import HTTPTypes

/// A client middleware that injects an `Api Key` into the header field of the request.
public struct ApiKeyMiddleware {

    /// The name for the `Api Key` header field.
    private let name: String
    
    /// The value for the `Api Key` header field.
    private let value: String

    /// Creates a new middleware.
    /// - Parameter name: The name for the `Api Key` header field.
    /// - Parameter value: The value for the `Api Key` header field.
    public init(apiKeyHeaderFieldName name: String, apiKeyHeaderFieldValue value: String) {
        self.name = name
        self.value = value
    }
}

extension ApiKeyMiddleware: ClientMiddleware {
    public func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        
        // Adds the api key to the header fields
        let apiKey = HTTPField(name: .init(self.name)!, value: self.value)
        request.headerFields.append(apiKey);
        
        return try await next(request, body, baseURL)
    }
}
