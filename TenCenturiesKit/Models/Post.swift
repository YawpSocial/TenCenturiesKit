//
//  Post.swift
//  Yawp
//
//  Created by Paul Schifferer on 21/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct Post {
    public var id : Int
    public var parentId : Int?
    public var title : String
    public var slug : String
    public var type : PostType
    public var privacy : Privacy
    public var guid : String
    public var content : Content?
    //    public var isAudio : Bool
    public var tags : [Tag] = []
    public var canonicalURL : URL
    public var fullURL : URL
    public var altURL : URL
    public var isHTTPS : Bool
    public var thread : Thread?
    public var mentions : [Mention] = []
    public var account : [Account]
    public var channel : Channel
    public var client : Client
    public var createdAt : Date
    public var createdUnix : Int
    public var publishAt : Date
    public var publishUnix : Int
    public var updatedAt : Date
    public var updatedUnix : Int
    public var expiresAt : Date?
    public var expiresUnix : Int?
    public var isMention : Bool
    public var youStarred : Bool
    public var youPinned : Pin?
    public var youReblurbed : Bool
    public var stars : Int?
    public var reposts : Int?
    public var parent : Indirect<Post>?
    public var followsYou : Bool
    public var youFollow : Bool
    public var youMuted : Bool
    public var youBlocked : Bool
    public var isVisible : Bool
    public var isDeleted : Bool
    public var files : [File]?
    //    public var geo : String?
    public var isMuted : Bool
}


public enum PostType : String {
    case micro = "post.micro"
    case social = "post.social"
    case tiny = "post.tiny"
    case short = "post.short"
    case long = "post.long"
    case invalid = "post.invalid"
}


extension Post : Serializable {

    public init?(from json : JSONDictionary) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let slug = json["slug"] as? String,
            let t = json["type"] as? String,
            let type = PostType(rawValue: t),
            let p = json["privacy"] as? String,
            let privacy = Privacy(rawValue: p),
            let guid = json["guid"] as? String,
            let urls = json["urls"] as? JSONDictionary,
            let isHTTPS = urls["is_https"] as? Bool,
            let canonicalURLStr = urls["canonical_url"] as? String,
            let canonicalURL = URL(string: canonicalURLStr),
            let fullURLStr = urls["full_url"] as? String,
            let fullURL = URLHelper.buildURL(from: fullURLStr, isHTTPS: isHTTPS),
            let altURLStr = urls["alt_url"] as? String,
            let altURL = URL(string: altURLStr),
            let accounts = json["account"] as? [JSONDictionary],
            let ch = json["channel"] as? JSONDictionary,
            let channel = Channel(from: ch),
            let cl = json["client"] as? JSONDictionary,
            let client = Client(from: cl),
            let c = json["created_at"] as? String,
            let createdAt = DateUtilities.isoFormatter.date(from: c),
            let createdUnix = json["created_unix"] as? Int,
            let pa = json["publish_at"] as? String,
            let publishAt = DateUtilities.isoFormatter.date(from: pa),
            let publishUnix = json["publish_unix"] as? Int,
            let u = json["updated_at"] as? String,
            let updatedAt = DateUtilities.isoFormatter.date(from: u),
            let updatedUnix = json["updated_unix"] as? Int,
            let isMuted = json["is_muted"] as? Bool
            else { return nil }

        self.id = id
        self.title = title
        self.slug = slug
        self.type = type
        self.privacy = privacy
        self.guid = guid
        self.isMuted = isMuted
        self.canonicalURL = canonicalURL
        self.fullURL = fullURL
        self.altURL = altURL
        self.channel = channel
        self.client = client
        self.createdAt = createdAt
        self.createdUnix = createdUnix
        self.publishAt = publishAt
        self.publishUnix = publishUnix
        self.updatedAt = updatedAt
        self.updatedUnix = updatedUnix

        self.account = accounts.flatMap { Account(from: $0) }

        if let content = json["content"] as? JSONDictionary {
            self.content = Content(from: content)
        }

        if let tags = json["tags"] as? [JSONDictionary] {
            self.tags = tags.flatMap { Tag(from: $0) }
        }

        self.isHTTPS = json["is_https"] as? Bool ?? false

        if let thread = json["thread"] as? JSONDictionary {
            self.thread = Thread(from: thread)
        }

        if let mentions = json["mentions"] as? [JSONDictionary] {
            self.mentions = mentions.flatMap { Mention(from: $0) }
        }

        if let expires = json["expires_at"] as? String {
            self.expiresAt = DateUtilities.isoFormatter.date(from: expires)
        }
        if let expires = json["expires_unix"] as? Int {
            self.expiresUnix = expires
        }

        self.isMention = json["is_mention"] as? Bool ?? false
        self.youStarred = json["you_starred"] as? Bool ?? false
        self.youReblurbed = json["you_reblurbed"] as? Bool ?? false
        self.followsYou = json["follows_you"] as? Bool ?? false
        self.youFollow = json["you_follow"] as? Bool ?? false
        self.youMuted = json["you_muted"] as? Bool ?? false
        self.youBlocked = json["you_blocked"] as? Bool ?? false
        self.isVisible = json["is_visible"] as? Bool ?? false
        self.isDeleted = json["is_deleted"] as? Bool ?? false

        if let pin = json["you_pinned"] as? String {
            self.youPinned = Pin(rawValue: pin)
        }

        if let v = json["stars"] as? Int {
            self.stars = v
        }
        if let v = json["reposts"] as? Int {
            self.reposts = v
        }

        if let parent = json["parent"] as? JSONDictionary,
            let p = Post(from: parent) {
            self.parent = Indirect<Post>(p)
        }
    }

    public func toDictionary() -> JSONDictionary {
        let (altUrl, isHTTPS) = URLHelper.trim(url: altURL)
        let (canonicalUrl, _) = URLHelper.trim(url: canonicalURL)
        let (fullUrl, _) = URLHelper.trim(url: fullURL)

        var dict : JSONDictionary = [
            "is_visible": isVisible,
            "updated_at": DateUtilities.isoFormatter.string(from: updatedAt),
            "you_reposted": youReblurbed,
            "guid": guid,
            "id": id,
            "publish_unix": publishUnix,
            "privacy": privacy.rawValue,
            "updated_unix": updatedUnix,
            "is_mention": isMention,
            "you_starred": youStarred,
            "type": type.rawValue,
            "channel": channel.toDictionary(),
            "is_muted": isMuted,
            "created_unix": createdUnix,
            "publish_at": DateUtilities.isoFormatter.string(from: publishAt),
            //            "geo": "",
            "slug": slug,
            "account": account.map { $0.toDictionary() },
            "is_deleted": isDeleted,
            "created_at": DateUtilities.isoFormatter.string(from: createdAt),
            "title": title,
            "client": client.toDictionary(),
            "urls": [
                "alt_url": altUrl,
                "canonical_url": canonicalUrl,
                "is_https": isHTTPS,
                "full_url": fullUrl,
            ],
            "mentions": mentions.map { $0.toDictionary() },
            //            "audio": isAudio,
            "tags" : tags.map({ $0.toDictionary() }),
            ]

        if let content = content {
            dict["content"] = content.toDictionary()
        }

        if let parentId = parentId,
            let parent = parent {
            dict["parent_id"] = parentId
            dict["parent"] = parent.value.toDictionary()
        }

        if let files = files {
            dict["files"] = files.map({ $0.toDictionary() })
        }

        if let stars = stars {
            dict["stars"] = stars
        }

        if let reposts = reposts {
            dict["reposts"] = reposts
        }

        if let expiresAt = expiresAt {
            dict["expires_at"] = expiresAt
        }
        if let expiresUnix = expiresUnix {
            dict["expires_unix"] = expiresUnix
        }

        if let thread = thread {
            dict["thread"] = thread.toDictionary()
        }

        if let pin = youPinned {
            dict["you_pinned"] = pin.rawValue
        }

        return dict
    }
}
/*
 {
 "is_visible": true,
 "updated_at": "2017-05-21T19:26:34Z",
 "you_reposted": false,
 "expires_unix": false,
 "guid": "faa3ef19722d6ee11e5fcf230b6d2a571af9a9d0",
 "id": 147475,
 "publish_unix": 1495394794,
 "privacy": "visibility.public",
 "updated_unix": 1495394794,
 "is_mention": false,
 "content": ...,
 "parent_id": false,
 "stars": false,
 "you_starred": false,
 "type": "post.social",
 "channel": ...,
 "files": false,
 "parent": false,
 "tags": false,
 "is_muted": false,
 "expires_at": false,
 "created_unix": 1495394794,
 "publish_at": "2017-05-21T19:26:34Z",
 "geo": "",
 "slug": "147475",
 "you_pinned": false,
 "account": ...,
 "is_deleted": false,
 "thread": {
 "reply_to": 147089,
 "thread_id": 146952,
 "is_selected": false
 },
 "created_at": "2017-05-21T19:26:34Z",
 "title": "",
 "client": ...,
 "urls": {
 "alt_url": "10centuries.org/147475",
 "canonical_url": "/post/147475",
 "is_https": true,
 "full_url": "10centuries.org/post/147475"
 },
 "mentions": [
 
 ],
 "audio": false,
 "reposts": 0
 },
 */
