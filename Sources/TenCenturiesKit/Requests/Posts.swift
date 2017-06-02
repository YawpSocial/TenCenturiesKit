import Foundation


public struct Posts {

    /**
     Delete a post.

     - parameter postId: The ID of the post to delete.
     */
    public static func delete(postId : Int) -> Request<DeleteResponse> {
        let method = HTTPMethod.delete

        return Request<DeleteResponse>(path: "/content/\(postId)", method: method, parse: Request<DeleteResponse>.parser)
    }

    // UNDOCUMENTED
    //    public static func edit() -> Request<Post> {
    //
    //    }
    //
    //    public static func list() -> Request<Post> {
    //
    //    }

    /**
     Get one or more posts by ID.

     - parameter postIds: An array of post IDs to retrieve.
     */
    public static func get(postIds : [Int]) -> Request<[Post]> {
        if postIds.count == 1,
            let postId = postIds.first {
            let method = HTTPMethod.get(Payload.empty)

            return Request<[Post]>(path: "/content/\(postId)", method: method, parse: Request<[Post]>.parser)
        }

        let parameters = [
            Parameter(name: "post_ids", value: postIds.map(String.init).joined(separator: ","))
        ]
        let method = HTTPMethod.get(Payload.parameters(parameters))

        return Request<[Post]>(path: "/content", method: method, parse: Request<[Post]>.parser)
    }

    //    public static func search() -> Request<Post> {
    //
    //    }

    /**
     Pin a post.

     - parameter pin: The pin to apply to the post.
     - parameter postId: The post to pin.
     */
    public static func pin(_ pin : Pin, postId : Int) -> Request<Empty> {
        let parameters = [
            Parameter(name: "post_id", value: "\(postId)"),
            Parameter(name: "colour", value: pin.rawValue),
            ]
        let method = HTTPMethod.post(Payload.parameters(parameters))

        return Request<Empty>(path: "/content/pin", method: method, parse: Request<Empty>.parser)
    }

    /**
     Repost a post.

     - parameter postId: The post to repost.
     */
    public static func repost(postId : Int) -> Request<Post> {
        let method = HTTPMethod.post(Payload.empty)

        return Request<Post>(path: "/content/repost/\(postId)", method: method, parse: Request<Post>.parser)
    }

    /**
     Star a post.

     - parameter postId: The post to star.
     */
    public static func star(postId : Int) -> Request<[Post]> {
        let method = HTTPMethod.post(Payload.empty)

        return Request<[Post]>(path: "/content/star/\(postId)", method: method, parse: Request<[Post]>.parser)
    }

    /**
     Create a new post.

     - parameter content: The text of the post.
     - parameter title: The (optional) title of the post.
     - parameter privacy: The privacy type of the post.
     */
    public static func create(content : String, title : String? = nil, privacy : Privacy = .public) -> Request<Post> {
        let parameters = [
            Parameter(name: "content", value: content),
            Parameter(name: "title", value: title.flatMap(toOptionalString)),
            Parameter(name: "privacy_type", value: privacy.rawValue),
            ]
        let method = HTTPMethod.post(Payload.parameters(parameters))

        return Request<Post>(path: "/content", method: method, parse: Request<Post>.parser)
    }

    /**
     Replies to a post.

     - parameter to: The ID of the post being replied to.
     - parameter content: The text of the post.
     - parameter title: The (optional) title of the post.
     - parameter privacy: The privacy type of the post.
     */
    public static func reply(to postId : Int, content : String, title : String? = nil, privacy : Privacy = .public) -> Request<Post> {
        let parameters = [
            Parameter(name: "content", value: content),
            Parameter(name: "reply_to", value: "\(postId)"),
            Parameter(name: "title", value: title.flatMap(toOptionalString)),
            Parameter(name: "privacy_type", value: privacy.rawValue),
            ]
        let method = HTTPMethod.post(Payload.parameters(parameters))
        
        return Request<Post>(path: "/content", method: method, parse: Request<Post>.parser)
    }
    
}
