//
//  Content.swift
//  Yawp
//
//  Created by Paul Schifferer on 21/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct Content {
    public var text : String
    public var html : String
    public var summary : String?
    public var banner : String?
    public var isEdited : Bool
}


extension Content : Serializable {
    public init?(from json : JSONDictionary) {
        guard let text = json["text"] as? String,
            let html = json["html"] as? String
            else { return nil }

        self.text = text
        self.html = html
        self.isEdited = json["is_edited"] as? Bool ?? false
        self.banner = json["banner"] as? String
        self.summary = json["summary"] as? String
    }

    public func toDictionary() -> JSONDictionary {
        var dict : JSONDictionary = [
            "text": text,
            "html": html,
            "is_edited": isEdited,
        ]

        if let summary = summary {
            dict["summary"] = summary
        }

        if let banner = banner {
            dict["banner"] = banner
        }

        return dict
    }
}


/*
 {
 "text": "@matigo You mean as in a call back to a URL I provide? I can do that. I'm just looking for a way that isn't polling, and provides everything that an app stream would expect to see, i.e., possibly non-publicly-visible posts, private messages, etc.",
 "html": "<p><span class=\"account\" data-account-id=\"1\">@matigo</span> You mean as in a call back to a URL I provide? I can do that. I'm just looking for a way that isn't polling, and provides everything that an app stream would expect to see, i.e., possibly non-publicly-visible posts, private messages, etc.</p>",
 "banner": false,
 "is_edited": false,
 "summary": false
 }
 */
