//
//  Thread.swift
//  Yawp
//
//  Created by Paul Schifferer on 21/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct Thread {
    public var replyTo : Int
    public var threadId : Int
    public var isSelected : Bool
}


extension Thread : Serializable {
    public init?(from json : JSONDictionary) {
        guard let replyTo = json["reply_to"] as? Int,
            let threadId = json["thread_id"] as? Int
            else { return nil }

        self.replyTo = replyTo
        self.threadId = threadId
        self.isSelected = json["is_selected"] as? Bool ?? false
    }

    public func toDictionary() -> JSONDictionary {
        let dict : JSONDictionary = [
            "reply_to": replyTo,
            "thread_id": threadId,
            "is_selected": isSelected,
            ]

        return dict
    }
}


/*
 {
 "reply_to": 147443,
 "thread_id": 147443,
 "is_selected": false
 }
 */
