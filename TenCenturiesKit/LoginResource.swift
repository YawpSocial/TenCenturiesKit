//
//  LoginResource.swift
//  TenCenturiesKit
//
//  Created by Paul Schifferer on 24/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation
import Alamofire


public class LoginResource : Resource {

    private var clientId : String
    private var scopes : [Scope]

    /**
     Designated initialiser for this resource.

     - parameter clientId: The client ID assigned to the client that will be performing the login.
     - parameter scopes: The scopes that the client will be requesting on behalf of the user.
     */
    public init(clientId : String, scopes : [Scope] = [ .basic ]) {
        self.clientId = clientId
        self.scopes = scopes
    }

    /**
     Perform a password grant login for the user.

     - parameter username: The user logging in.
     - parameter password: The user's credentials.
     - parameter grantSecret:  This is a password grant secret (for a password grant login).
     - parameter completion: A closure that will be called when the login is complete, passed the results of the login attempt.
     */
    public func login(username : String, password : String, grantSecret : String, completion : (_ accessToken : String?, _ token : Token?, _ userId : String?, _ username : String?, _ error : Error?) -> Void) {

    }

    public func logout() {

    }

    public enum Scope : String {
        case basic = "basic"
        case stream = "stream"
        case writePost = "write_post"
        case follow = "follow"
        case updateProfile = "update_profile"
        case presence = "presence"
        case messages = "messages"
        case publicMessages = "public_messages"
    }
    
}
