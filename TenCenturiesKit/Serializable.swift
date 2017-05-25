//
//  Serializable.swift
//  TenCenturiesKit
//
//  Created by Paul Schifferer on 24/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public protocol Serializable {

    init?(from json : [String : Any])

    func toDictionary() -> [String : Any]

}
