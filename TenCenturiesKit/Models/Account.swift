//
//  Account.swift
//  Yawp
//
//  Created by Paul Schifferer on 21/5/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct Account {
    public var id : Int
    public var username : String
    public var firstName : String
    public var lastName : String
    public var display : String
    public var evangelist : Bool
    public var isVerified : Bool
    public var verifiedURL : URL?
    public var podcastURL : URL?
    public var isMuted : Bool
    public var followsYou : Bool
    public var createdAt : Date
    public var canonicalURL : URL
    public var avatarURL : URL
    public var annotations : [Annotation] = []
    public var youFollow : Bool
    public var coverImage : URL?
    public var timezone : String
    public var counts : Counts = Counts()
    public var descriptionText : String
    public var descriptionHTML : String
    public var isSilenced : Bool

    public struct Counts {
        public var podcasts : Int = 0
        public var followers : Int = 0
        public var stars : Int = 0
        public var following : Int = 0
        public var blogPosts : Int = 0
        public var socialPosts : Int = 0
    }
}


extension Account : Serializable {
    public init?(from json : JSONDictionary) {
        guard let id = json["id"] as? Int,
            let username = json["username"] as? String,
            let name = json["name"] as? [String : String],
            let firstName = name["first_name"],
            let lastName = name["last_name"],
            let display = name["display"],
            let evangelist = json["evangelist"] as? Bool,
            let c = json["created_at"] as? String,
            let createdAt = DateUtilities.isoFormatter.date(from: c),
            let cu = json["canonical_url"] as? String,
            let canonicalURL = URL(string: cu),
            let au = json["avatar_url"] as? String,
            let avatarURL = URLHelper.buildURL(from: au, isHTTPS: true),
            let timezone = json["timezone"] as? String,
            let counts = json["counts"] as? [String : Int],
            let blogPosts = counts["blog_posts"],
            let followers = counts["followers"],
            let following = counts["following"],
            let podcasts = counts["podcasts"],
            let socialPosts = counts["socialposts"],
            let stars = counts["stars"],
            let desc = json["description"] as? [String : String],
            let descText = desc["text"],
            let descHTML = desc["html"]
            else { return nil }

        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.display = display
        self.evangelist = evangelist

        if let verified = json["verified"] as? JSONDictionary {
            self.isVerified = verified["is_verified"] as? Bool ?? false
            if let url = verified["url"] as? String {
                self.verifiedURL = URL(string: url)
            }
        }
        else {
            self.isVerified = false
        }

        if let p = json["podcast_url"] as? String {
            self.podcastURL = URL(string: p)
        }

        self.isMuted = json["is_muted"] as? Bool ?? false
        self.followsYou = json["follows_you"] as? Bool ?? false
        self.createdAt = createdAt
        self.canonicalURL = canonicalURL
        self.avatarURL = avatarURL
        self.annotations = (json["annotations"] as? [JSONDictionary])?.flatMap { Annotation(from: $0) } ?? []
        self.youFollow = json["you_follow"] as? Bool ?? false

        if let url = json["cover_image"] as? String {
            self.coverImage = URL(string: url)
        }

        self.timezone = timezone
        self.counts.blogPosts = blogPosts
        self.counts.followers = followers
        self.counts.following = following
        self.counts.podcasts = podcasts
        self.counts.socialPosts = socialPosts
        self.counts.stars = stars
        self.descriptionText = descText
        self.descriptionHTML = descHTML
        self.isSilenced = json["is_silenced"] as? Bool ?? false
    }

    public func toDictionary() -> JSONDictionary {
        var dict : JSONDictionary = [
            "username": username,
            "evangelist": evangelist,
            "is_silenced": isSilenced,
            "name": [
                "first_name": firstName,
                "last_name": lastName,
                "display": display,
            ],
            "is_muted": isMuted,
            "follows_you": followsYou,
            "created_at": DateUtilities.isoFormatter.string(from: createdAt),
            "canonical_url": canonicalURL.absoluteString,
            "avatar_url": avatarURL.absoluteString,
            "you_follow": youFollow,
            "timezone": timezone,
            "counts": [
                "podcasts": counts.podcasts,
                "followers": counts.followers,
                "stars": counts.stars,
                "following": counts.following,
                "blogposts": counts.blogPosts,
                "socialposts": counts.socialPosts,
            ],
            "id": id,
            "description": [
                "text": descriptionText,
                "html": descriptionHTML,
            ],
            "annotations" : annotations.map({ $0.toDictionary() }),
            ]

        if let podcastRSS = podcastURL {
            dict["podcast_rss"] = podcastRSS
        }

        if let cover = coverImage {
            dict["cover_image"] = cover.absoluteString
        }

        if isVerified,
            let url = verifiedURL {
            let v : NSDictionary = [
                "url": url.absoluteString,
                "is_verified": isVerified,
                ]

            dict["verified"] = v
        }

        return dict
    }
}


/*
 {
 "username": "paulyhedral",
 "evangelist": false,
 "is_silenced": false,
 "verified": {
 "url": "",
 "is_verified": false
 },
 "name": {
 "first_name": "Paul",
 "last_name": "Schifferer",
 "display": "Paul Schifferer"
 },
 "podcast_rss": false,
 "is_muted": false,
 "follows_you": true,
 "created_at": "2016-09-08T22:13:44Z",
 "canonical_url": "https://10centuries.org/profile/paulyhedral",
 "avatar_url": "//cdn.10centuries.org/4Jd3o7/8337880843dccc184fc1d4b1bdfdbc85.png",
 "annotations": false,
 "you_follow": true,
 "cover_image": false,
 "timezone": "America/Los_Angeles",
 "counts": {
 "podcasts": 0,
 "followers": 25,
 "stars": 9,
 "following": 26,
 "blogposts": 0,
 "socialposts": 166
 },
 "id": 99,
 "description": {
 "text": "",
 "html": ""
 }
 }
 */
