import Foundation


public struct Star {
    public let id : Int
    public let name : String
    public let avatarURL : URL
    public let starredAt : Date
    public let starredUnix : Int
}


extension Star : Serializable {

    public init?(from json: JSONDictionary) {
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let u = json["avatar_url"] as? String,
            let avatarUrl = URLHelper.buildURL(from: u, isHTTPS: true),
            let s = json["starred_at"] as? String,
            let starredAt = DateUtilities.isoFormatter.date(from: s),
            let starredUnix = json["starred_unix"] as? Int
            else { return nil }

        self.id = id
        self.name = name
        self.avatarURL = avatarUrl
        self.starredAt = starredAt
        self.starredUnix = starredUnix
    }

    public func toDictionary() -> JSONDictionary {
        let dict : JSONDictionary = [
            "id" : id,
            "name" : name,
            "avatar_url" : URLHelper.trim(url: avatarURL).0,
            "starred_at" : DateUtilities.isoFormatter.string(from: starredAt),
            "starred_unix" : starredUnix,
            ]

        return dict
    }
}
