//
//  URLBuilder.swift
//  Yawp
//
//  Created by Paul Schifferer on 21/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct URLHelper {

    public static func buildURL(from urlBase : String, isHTTPS : Bool) -> URL? {
        return URL(string: "http\(isHTTPS ? "s" : "")://\(urlBase)")
    }

    public static func trim(url : URL) -> (String, Bool) {
        let s = url.absoluteString

        if s.hasPrefix("https:") {
            return (s.substring(from: s.index(s.startIndex, offsetBy: 6)), true)
        }
        else if s.hasPrefix("http:") {
            return (s.substring(from: s.index(s.startIndex, offsetBy: 5)), false)
        }

        return (s, false)
    }
    
}
