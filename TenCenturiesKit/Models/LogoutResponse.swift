import Foundation


public struct LogoutResponse {
    public let isActive : Bool
    public let updatedAt : Date
    public let updatedUnix : Int
}


extension LogoutResponse : Serializable {

    public init?(from json : JSONDictionary) {
        guard let isActive = json["is_active"] as? Bool,
            let u = json["updated_at"] as? String,
            let updatedAt = DateUtilities.isoFormatter.date(from: u),
            let updatedUnix = json["updated_unix"] as? Int
            else { return nil }

        self.isActive = isActive
        self.updatedAt = updatedAt
        self.updatedUnix = updatedUnix
    }

    public func toDictionary() -> JSONDictionary {
        let dict : JSONDictionary = [
            "is_active" : isActive,
            "updated_at" : DateUtilities.isoFormatter.string(from: updatedAt),
            "updated_unix" : updatedUnix,
            ]

        return dict
    }
    
}
