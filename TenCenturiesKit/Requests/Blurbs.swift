import Foundation


public struct Blurbs {

    /**
     Retrieves the home timeline.

     - parameter range: The bounds used when requesting data from 10 Centuries.
     - returns: Request for `[Post]`.
     */
    public static func home(range : RequestRange = .default) -> Request<[Post]> {
        let rangeParameters = range.parameters(limit: between(1, and: 40, fallback: 20))
        //        let localParameters = r
        let method = HTTPMethod.get(Payload.parameters(rangeParameters))

        return Request<[Post]>(path: "/content/blurbs/home", method: method, parse: Request<[Post]>.parser)
    }

    /**
     Retrieves the global timeline.

     - parameter range: The bounds used when requesting data from 10 Centuries.
     - returns: Request for `[Post]`.
     */
    public static func global(range : RequestRange = .default) -> Request<[Post]> {
        let rangeParameters = range.parameters(limit: between(1, and: 40, fallback: 20))
        let method = HTTPMethod.get(Payload.parameters(rangeParameters))

        return Request<[Post]>(path: "/content/blurbs/global", method: method, parse: Request<[Post]>.parser)
    }

    /**
     Retrieves interactions for the current account.

     - parameter range: The bounds used when requesting data from 10 Centuries.
     - returns: Request for `[Post]`.
     */
    public static func interactions(range : RequestRange = .default) -> Request<[Post]> {
        let rangeParameters = range.parameters(limit: between(1, and: 40, fallback: 20))
        let method = HTTPMethod.get(Payload.parameters(rangeParameters))

        return Request<[Post]>(path: "/content/blurbs/interactions", method: method, parse: Request<[Post]>.parser)
    }

    /**
     Retrieves mentions for the current account.

     - parameter range: The bounds used when requesting data from 10 Centuries.
     - returns: Request for `[Post]`.
     */
    public static func mentions(range : RequestRange = .default) -> Request<[Post]> {
        let rangeParameters = range.parameters(limit: between(1, and: 40, fallback: 20))
        let method = HTTPMethod.get(Payload.parameters(rangeParameters))

        return Request<[Post]>(path: "/content/blurbs/mentions", method: method, parse: Request<[Post]>.parser)
    }

    /**
     Retrieves pins for the current account.

     - parameter range: The bounds used when requesting data from 10 Centuries.
     - returns: Request for `[Post]`.
     */
    public static func pins(range : RequestRange = .default) -> Request<[Post]> {
        let rangeParameters = range.parameters(limit: between(1, and: 40, fallback: 20))
        let method = HTTPMethod.get(Payload.parameters(rangeParameters))

        return Request<[Post]>(path: "/content/blurbs/pins", method: method, parse: Request<[Post]>.parser)
    }
    
}
