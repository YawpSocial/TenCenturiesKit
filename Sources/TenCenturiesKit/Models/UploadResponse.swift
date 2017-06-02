import Foundation


public struct UploadResponse {
    public let files : [File]
    public let bucket : [Bucket]
    public let errors : [UploadError]
}


extension UploadResponse : Serializable {

    public init?(from json: JSONDictionary) {
        guard let files = json["files"] as? [JSONDictionary],
            let bucket = json["bucket"] as? [JSONDictionary],
            let errors = json["errors"] as? [JSONDictionary]
            else { return nil }

        self.files = files.flatMap(File.init(from:))
        self.bucket = bucket.flatMap(Bucket.init(from:))
        self.errors = errors.flatMap(UploadError.init(from:))
    }

    public func toDictionary() -> JSONDictionary {
        let dict : JSONDictionary = [
            "files" : files.map { $0.toDictionary() },
            "bucket" : bucket.map { $0.toDictionary() },
            "errors" : errors.map { $0.toDictionary() },
            ]

        return dict
    }
    
}
