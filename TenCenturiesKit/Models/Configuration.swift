//
//  TenCenturiesConfiguration.swift
//  Yawp
//
//  Created by Paul Schifferer on 4/4/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct Configuration {

    public init() {
        
    }
}


extension Configuration : Serializable {
    public init?(from json : JSONDictionary) {

    }

    public func toDictionary() -> JSONDictionary {
        let dict : JSONDictionary = [
            :
        ]

        return dict
    }
}

