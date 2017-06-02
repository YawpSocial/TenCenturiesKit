import Foundation


public struct Files {

    /**
     Uploads a file.

     - parameter media: The file contents.
     - returns: A response object indicating the status of the upload.
     */
    public static func upload(media : MediaAttachment) -> Request<UploadResponse> {
        let method = HTTPMethod.post(.media(media))

        return Request<UploadResponse>(path: "/files/upload", method: method, parse: Request<UploadResponse>.parser)
    }

    /**
     Gets a file.

     - parameter fileId: The ID of the file to get.
     - returns: The file.
     */
    public static func get(fileId : Int) -> Request<File> {
        let method = HTTPMethod.get(Payload.empty)

        return Request<File>(path: "/files/\(fileId)", method: method, parse: Request<File>.parser)
    }

    /**
     Delete a file.

     - parameter fileId: The ID of the file to delete.
     - returns: The file that was deleted.
     */
    public static func delete(fileId : Int) -> Request<File> {
        let method = HTTPMethod.delete

        return Request<File>(path: "/files/\(fileId)", method: method, parse: Request<File>.parser)
    }
    
}
