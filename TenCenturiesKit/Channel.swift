//
//  Channel.swift
//  Yawp
//
//  Created by Paul Schifferer on 21/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation
import PilgrimageKit


public struct Channel {
    public var id : Int
    public var guid : String
    public var createdAt : Date
    public var createdUnix : Int
    public var updatedAt : Date
    public var updatedUnix : Int
    public var type : ChannelType
    public var privacy : Privacy
    public var ownerId : Int?
}


public enum ChannelType : String {
    case `public` = "visibility.public"
    case followers = "visibility.followers"
    case me = "visibility.me"
}


extension Channel : Serializable {
    public init?(from json : [String : Any]) {
        guard let id = json["id"] as? Int,
            let guid = json["guid"] as? String,
            let c = json["created_at"] as? String,
            let createdAt = DateUtilities.isoFormatter.date(from: c),
            let createdUnix = json["created_unix"] as? Int,
            let u = json["updated_at"] as? String,
            let updatedAt = DateUtilities.isoFormatter.date(from: u),
            let updatedUnix = json["updated_unix"] as? Int,
            let t = json["type"] as? String,
            let type = ChannelType(rawValue: t),
            let p = json["privacy"] as? String,
            let privacy = Privacy(rawValue: p)
            else { return nil }

        self.id = id
        self.guid = guid
        self.createdAt = createdAt
        self.createdUnix = createdUnix
        self.updatedAt = updatedAt
        self.updatedUnix = updatedUnix
        self.type = type
        self.privacy = privacy
        self.ownerId = json["owner_id"] as? Int
    }

    public func toDictionary() -> NSDictionary {
        let dict : NSDictionary = [
            "privacy": privacy.rawValue,
            "created_at": DateUtilities.isoFormatter.string(from: createdAt),
            "updated_unix": createdUnix,
            "updated_at": DateUtilities.isoFormatter.string(from: updatedAt),
            "created_unix": createdUnix,
            "guid": guid,
            "type": type.rawValue,
            "id": id,
        ]

        if let ownerId = ownerId {
            dict.setValue(ownerId, forKey: "owner_id")
        }

        return dict
    }
}


/*
 {
 "privacy": "visibility.public",
 "created_at": "2015-08-01T00:00:00Z",
 "updated_unix": 1438387200,
 "updated_at": "2015-08-01T00:00:00Z",
 "created_unix": 1438387200,
 "guid": "d9ba5a8d768d0dbd9fc9c3ea4c8e183b2aa7336c",
 "type": "channel.global",
 "id": 1,
 "owner_id": false
 }
 */
