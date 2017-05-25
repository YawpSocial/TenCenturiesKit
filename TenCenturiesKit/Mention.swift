//
//  Mention.swift
//  Yawp
//
//  Created by Paul Schifferer on 21/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation
import PilgrimageKit


public struct Mention {
    public var current : String
    public var id : Int
    public var name : String
}


extension Mention : Serializable {
    public init?(from json : [String : Any]) {
        guard let name = json["name"] as? String,
            let id = json["id"] as? Int,
            let current = json["current"] as? String
            else { return nil }

        self.current = current
        self.id = id
        self.name = name
    }

    public func toDictionary() -> NSDictionary {
        let dict : NSDictionary = [
            "current": current,
            "id": id,
            "name": name,
            ]

        return dict
    }
}

/*
 {
 "current": "@matigo",
 "id": 1,
 "name": "@matigo"
 }
 */
