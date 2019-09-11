//
//  Provider.swift
//  Food Recipies
//
//  Created by admin on 9/11/19.
//  Copyright © 2019 kero. All rights reserved.
//

import Foundation
import Alamofire

class Provider{
    static let apiService: SearchApiService = MockSearchApiService()
    
    public static var sessionManager: Alamofire.SessionManager  {

        return  {
            // Create the server trust policies
            let serverTrustPolicies: [String: ServerTrustPolicy] = [
                "*.edamam.com": .disableEvaluation
            ]
        
            // Create custom manager
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            let manager = Alamofire.SessionManager(
                configuration: URLSessionConfiguration.default,
                serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
            )
        
            return manager
        }() 
    }
}
