//
//  Highwind+Injection.swift
//  Highwind
//
//  Created by Kristian Mitra on 2/17/24.
//

import Factory
import HighwindLibrary

extension Container : AutoRegistering {
    
    public func autoRegister() {

        // MARK: Data Services
        mobileConfiguration.register { MobileConfiguration() }
        
        digialApiDataClient.register {
            DigitalApiDataClient(
                mobileConfiguration: self.mobileConfiguration(),
                requestHandlers: [
                    HttpNavitaireTokenAuthHandler(mobileConfiguration: self.mobileConfiguration()),
                    HttpAzureApiKeyHandler(mobileConfiguration: self.mobileConfiguration())
                ]
            )
        }
    }
}

