import Foundation


public struct DeleteResponse {
    public let id : Int
    public let isVisible : Bool
    public let isDeleted : Bool
}


extension DeleteResponse : Serializable {

    public init?(from json : JSONDictionary) {
        guard
            let id = json["id"] as? Int,
            let isVisible = json["is_visible"] as? Bool,
            let isDeleted = json["is_deleted"] as? Bool
            else { return nil }

        self.id = id
        self.isVisible = isVisible
        self.isDeleted = isDeleted
    }

    public func toDictionary() -> JSONDictionary {
        let dict : JSONDictionary = [
            "id" : id,
            "is_visible" : isVisible,
            "is_deleted" : isDeleted,
            ]

        return dict
    }
    
}
