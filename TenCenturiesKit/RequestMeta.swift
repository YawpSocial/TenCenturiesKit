//
//  RequestMeta.swift
//  TenCenturiesKit
//
//  Created by Paul Schifferer on 24/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct RequestMeta {
    public var code : Int
    public var more : Bool?
    public var minId : String?
    public var maxId : String?
}

extension RequestMeta : Serializable {

    public init?(from json : [String : Any]) {
        guard let code = json["code"] as? Int
            else { return nil }

        self.code = code
        self.more = json["more"] as? Bool
        self.minId = json["min_id"] as? String
        self.maxId = json["max_id"] as? String
    }

    public func toDictionary() -> [String : Any] {
        let dict : [String : Any] = [
            "code" : code,
            ]
        
        return dict
    }
    
}
