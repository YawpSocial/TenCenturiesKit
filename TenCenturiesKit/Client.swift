//
//  Client.swift
//  Yawp
//
//  Created by Paul Schifferer on 21/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation
import PilgrimageKit


public struct Client {
    public var hash : String
    public var name : String
}


extension Client : Serializable {
    public init?(from json : [String : Any]) {
        guard let name = json["name"] as? String,
            let hash = json["hash"] as? String
            else { return nil }

        self.name = name
        self.hash = hash
    }

    public func toDictionary() -> NSDictionary {
        let dict : NSDictionary = [
            "hash": hash,
            "name": name,
        ]

        return dict
    }
}


/*
 {
 "hash": "a4e797c491b139358ab6d58acf7f11733102cc9c",
 "name": "Cappuccino"
 }
 */
