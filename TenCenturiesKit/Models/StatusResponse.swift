import Foundation


public struct StatusResponse {
    public let account : Account
    public let isActive : Bool
    public let updatedAt : Date
    public let updatedUnix : Int
}


extension StatusResponse : Serializable {

    public init?(from json : JSONDictionary) {
        guard
            let a = json["account"] as? JSONDictionary,
            let account = Account(from: a),
            let isActive = json["is_active"] as? Bool,
            let u = json["updated_at"] as? String,
            let updatedAt = ISO8601DateFormatter().date(from: u),
            let updatedUnix = json["updated_unix"] as? Int
            else { return nil }

        self.account = account
        self.isActive = isActive
        self.updatedAt = updatedAt
        self.updatedUnix = updatedUnix
    }

    public func toDictionary() -> JSONDictionary {
        let dict : JSONDictionary = [
            "account" : account.toDictionary(),
            "is_active" : isActive,
            "updated_at" : ISO8601DateFormatter().string(from: updatedAt),
            "updated_unix" : updatedUnix,
            ]
        
        return dict
    }
    
}
