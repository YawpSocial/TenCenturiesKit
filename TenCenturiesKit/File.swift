//
//  File.swift
//  Yawp
//
//  Created by Paul Schifferer on 21/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation
import PilgrimageKit


public struct File {
    public var id : Int
    public var uploadedAt : Date
    public var uploadedUnix : Int
    public var updatedAt : Date
    public var updatedUnix : Int
    public var originalName : String
    public var cdnFile : String
    public var mimeType : String
    public var size : Int
    public var isDeleted : Bool
    public var isAnimated : Bool
}


extension File : Serializable {
    public init?(from json : [String : Any]) {
        guard let id = json["id"] as? Int,
            let u = json["uploaded_at"] as? String,
            let uploadedAt = DateUtilities.isoFormatter.date(from: u),
            let uploadedUnix = json["uploaded_unix"] as? Int,
            let u2 = json["updated_at"] as? String,
            let updatedAt = DateUtilities.isoFormatter.date(from: u2),
            let updatedUnix = json["updated_unix"] as? Int,
            let originalName = json["original_name"] as? String,
            let cdnFile = json["cdn_file"] as? String,
            let mimeType = json["mime_type"] as? String,
            let size = json["size"] as? Int
            else { return nil }

        self.id = id
        self.uploadedAt = uploadedAt
        self.uploadedUnix = uploadedUnix
        self.updatedAt = updatedAt
        self.updatedUnix = updatedUnix
        self.originalName = originalName
        self.cdnFile = cdnFile
        self.mimeType = mimeType
        self.size = size
        self.isDeleted = json["is_deleted"] as? Bool ?? false
        self.isAnimated = json["is_animated"] as? Bool ?? false
    }

    public func toDictionary() -> NSDictionary {
        let dict : NSDictionary = [
            "uploaded_at" : DateUtilities.isoFormatter.string(from: uploadedAt),
            "is_deleted": isDeleted,
            "updated_unix": uploadedUnix,
            "original_name": originalName,
            "updated_at": DateUtilities.isoFormatter.string(from: updatedAt),
            "cdn_file": cdnFile,
            "animated": isAnimated,
            "uploaded_unix": uploadedUnix,
            "id": id,
            "mime_type": mimeType,
            "size": size,
            ]

        return dict
    }
}


/*
 {
 "uploaded_at": "2017-05-21 18:55:33",
 "is_deleted": false,
 "updated_unix": 1495392933,
 "original_name": "img_7918.jpg",
 "updated_at": "2017-05-21 18:55:33",
 "cdn_file": "6bf12e22dc3981bd25601a83f70e1d84.jpg",
 "animated": false,
 "uploaded_unix": 1495392933,
 "id": 6623,
 "mime_type": "image/jpeg",
 "size": 2177015
 }
 */
