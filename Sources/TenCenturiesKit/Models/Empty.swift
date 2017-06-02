import Foundation


public struct Empty {

}

extension Empty : Serializable {

    public init?(from json: JSONDictionary) {

    }

    public func toDictionary() -> JSONDictionary {
        return [:]
    }

}
