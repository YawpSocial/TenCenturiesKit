//
//  APIClient.swift
//  TenCenturiesKit
//
//  Created by Paul Schifferer on 24/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation
import Alamofire


public class APIClient {

    private var clientId : String
    private var accessToken : String?

    public init(clientId : String, accessToken : String? = nil) {
        self.clientId = clientId
        self.accessToken = accessToken
    }

    public func execute(_ request : Alamofire.Request, completion : @escaping (_ json : [String : Any]?, _ error : Error?) -> Void) {

        var headers : HTTPHeaders = [
            "Content-type" : "application/json",
        ]
        if let accessToken = self.accessToken {
            headers["Authorization"] = "Bearer \(accessToken)"
        }

        request.encoding = JSONEncoding.default
        request.headers = headers
        request.validate()
            .responseJSON { response in

                switch response.result {
                case .success:
                    if let json = response.result.value as? [String : Any] {
                        completion(json, nil)
                    }
                    else {
                        completion(nil, Errors.invalidResponseType)
                    }

                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
}
