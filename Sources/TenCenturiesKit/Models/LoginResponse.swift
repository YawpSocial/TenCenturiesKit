import Foundation


public struct LoginResponse {
    public let token : String
}


extension LoginResponse : Serializable {

    public init?(from json : JSONDictionary) {
        guard
            let token = json["token"] as? String
            else { return nil }

        self.token = token
    }

    public func toDictionary() -> JSONDictionary {
        let dict : JSONDictionary = [
            "token" : token
        ]

        return dict
    }
    
}
