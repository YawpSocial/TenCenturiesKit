//
//  Annotation.swift
//  Yawp
//
//  Created by Paul Schifferer on 21/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation
import PilgrimageKit


public struct Annotation {
}


extension Annotation : Serializable {
    public init?(from json : [String : Any]) {
        //        guard let id = json["id"] as? Int,
        //            let guid = json["guid"] as? String,
        //            let c = json["created_at"] as? String,
        //            let createdAt = DateUtilities.isoFormatter.date(from: c),
        //            let createdUnix = json["created_unix"] as? Int,
        //            let u = json["updated_at"] as? String,
        //            let updatedAt = DateUtilities.isoFormatter.date(from: u),
        //            let updatedUnix = json["updated_unix"] as? Int,
        //            let t = json["type"] as? String,
        //            let type = ChannelType(rawValue: t),
        //            let p = json["privacy"] as? String,
        //            let privacy = Privacy(rawValue: p)
        //            else { return nil }
        //
        //        self.id = id
        //        self.guid = guid
        //        self.createdAt = createdAt,
        //        self.createdUnix = createdUnix
        //        self.updatedAt = updatedAt
        //        self.updatedUnix = updatedUnix
        //        self.type = type
        //        self.privacy = privacy
        //        self.ownerId = json["owner_id"] as? Int
    }

    public func toDictionary() -> NSDictionary {
        let dict : NSDictionary = [
            :
        ]
        
        return dict
    }
}
