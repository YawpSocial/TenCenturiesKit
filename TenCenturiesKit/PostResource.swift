//
//  PostResource.swift
//  TenCenturiesKit
//
//  Created by Paul Schifferer on 24/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation
import Alamofire


public class PostResource : Resource {

    private var client : APIClient

    public init(client : APIClient) {
        self.client = client
    }

    public func create(text : String, raw : [Raw]? = nil, isNSFW : Bool = false, updateMarker : Bool = true, completion : @escaping (_ post : Post?, _ error : Error?) -> Void) {
        var params : Parameters = [
            "text" : text,
            "entities.parse_links" : true,
            "entities.parse_markdown_links" : true,
            "is_nsfw" : isNSFW,
            "update_marker" : updateMarker,
            ]
        let request = Alamofire.request("\(TenCenturiesAPIBase)/posts",
            method: .post,
            parameters: params)
        self.client.execute(request) { json, error in
            completion(Post(from: json ?? [:]), error)
        }
    }

    public func get(postId : String, completion : @escaping (_ post : Post?, _ error : Error?) -> Void) {

    }

    public func get(postsFrom startingPostId : String, to endingPostId : String, completion : @escaping (_ posts : [Post], _ meta : RequestMeta, _ error : Error?) -> Void) {

    }

    public func delete(postId : String) {

    }

}
