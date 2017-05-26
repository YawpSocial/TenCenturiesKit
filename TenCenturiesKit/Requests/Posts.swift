import Foundation


public struct Posts {

    public static func create(content : String) -> Request<Post> {
        let parameters = [
            Parameter(name: "content", value: content),
            ]
        let method = HTTPMethod.post(Payload.parameters(parameters))

        return Request<Post>(path: "/content", method: method, parse: Request<Post>.parser)
    }

    public static func reply(to postId : Int, content : String) -> Request<Post> {
        let parameters = [
            Parameter(name: "content", value: content),
            Parameter(name: "reply_to", value: "\(postId)")
        ]
        let method = HTTPMethod.post(Payload.parameters(parameters))

        return Request<Post>(path: "/content", method: method, parse: Request<Post>.parser)
    }
    
}
