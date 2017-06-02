import Foundation


public struct Bucket {
    public let type : String
    public let files : Int
    public let limit : Int
    public let used : Int
}


extension Bucket : Serializable {

    public init?(from json : JSONDictionary) {
        guard let type = json["type"] as? String,
            let files = json["files"] as? Int,
            let limit = json["limit"] as? Int,
            let used = json["used"] as? Int
            else { return nil }

        self.type = type
        self.files = files
        self.limit = limit
        self.used = used
    }

    public func toDictionary() -> JSONDictionary {
        let dict : JSONDictionary = [
            "type" : type,
            "files" : files,
            "limit" : limit,
            "used" : used,
            ]
        
        return dict
    }
    
}
