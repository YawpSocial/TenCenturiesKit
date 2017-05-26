import Foundation


public struct UploadError {
    public let name : String
    public let size : Int
    public let type : String
    public let reason : String
}


extension UploadError : Serializable {

    public init?(from json: JSONDictionary) {
        guard let name = json["name"] as? String,
            let size = json["size"] as? Int,
            let type = json["type"] as? String,
            let reason = json["reason"] as? String
            else { return nil }

        self.name = name
        self.size = size
        self.type = type
        self.reason = reason
    }

    public func toDictionary() -> JSONDictionary {
        let dict : JSONDictionary = [
            "name" : name,
            "size" : size,
            "type" : type,
            "reason" : reason,
            ]
        
        return dict
    }
    
}
