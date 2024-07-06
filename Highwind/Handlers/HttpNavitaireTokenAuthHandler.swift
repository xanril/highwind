//
//  HttpNavitaireAuthHandler.swift
//  Highwind
//
//  Created by Kristian Mitra on 2/9/24.
//

import Foundation
import DigitalAPIClient
import OpenAPIRuntime
import OpenAPIURLSession
import HWDDataServiceProtocols

public class HttpNavitaireTokenAuthHandler: RequestHandlerProtocol {
    
    // MARK: - Fields
    private var mobileConfiguration: MobileConfigurationProtocol
    
    static private var token: String = "";
    
    // MARK: - Constructor
    public init(mobileConfiguration: MobileConfigurationProtocol?) {
        guard let _ = mobileConfiguration else { fatalError() }
        self.mobileConfiguration = mobileConfiguration!
    }
    
    // MARK: - Methods
    
    public func getMiddlewareAsync() async -> ClientMiddleware? {
        if (Task.isCancelled)
        {
            return nil
        }
            
        if (HttpNavitaireTokenAuthHandler.token.isEmpty)
        {
            // check if user is logged in.
            let isLoggedIn = false;
         
            await requestAnonymousTokenAsync()
        }
        else
        {
            // check if token is expired
            
            // if expired
            // request another token
        }
        
        return AuthenticationMiddleware(authorizationHeaderFieldValue: HttpNavitaireTokenAuthHandler.token)
    }
    
    public func requestAnonymousTokenAsync() async {
        
        do
        {
            let client = Client(
                serverURL: URL(string: mobileConfiguration.defaultBaseUrl)!,
                transport: URLSessionTransport(),
                middlewares: [
                    ApiKeyMiddleware(
                        apiKeyHeaderFieldName: mobileConfiguration.defaultGatewaySubscriptionKey,
                        apiKeyHeaderFieldValue: mobileConfiguration.defaultGatewaySubscriptionValue)])
            
            // Commenting for now. This is the request to use Jwt
//            let jwtRefreshRequest = Components.Schemas.JwtRefreshRequest(
//                applicationName: mobileConfiguration.tokenApplicationName,
//                cultureCode: "en-US")
//            
//            let response = try await client.auth_v1_token_anonymous_post(
//                body: Operations.auth_v1_token_anonymous_post.Input.Body.json(jwtRefreshRequest))
            
            let tokenRequest = Components.Schemas.TokenV2RefreshRequest(
                credentials: Components.Schemas.TokenV2Credentials(
                    location: "WWW", 
                    systemName: "Mobile",
                    channelType: "Api",
                    loginRole: ""),
            applicationName: "Mobile")
            
            let response = try await client.nsk_v2_token_post(body: .json(tokenRequest))
            
            let newToken = try response.created.body.json.data?.token ?? ""
            HttpNavitaireTokenAuthHandler.token = newToken
        }
        catch {
            print(error)
        }
    }
    
    func requestMemberToken() {
        
    }
}
