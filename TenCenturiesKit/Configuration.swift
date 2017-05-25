//
//  TenCenturiesConfiguration.swift
//  Yawp
//
//  Created by Paul Schifferer on 4/4/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation
import PilgrimageKit


public struct Configuration {

    public init() {
        
    }
}


extension Configuration : Serializable {
    public init?(from json : [String : Any]) {

    }

    public func toDictionary() -> NSDictionary {
        let dict : NSDictionary = [
            :
        ]

        return dict
    }
}

