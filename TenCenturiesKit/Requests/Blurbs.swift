import Foundation


public struct Blurbs {

    /// Retrieves the home timeline.
    ///
    /// - Parameter range: The bounds used when requesting data from Pnut.io.
    /// - Returns: Request for `[Post]`.
    public static func home(range : RequestRange = .default) -> Request<[Post]> {
        let rangeParameters = range.parameters(limit: between(1, and: 40, fallback: 20))
//        let localParameters = r
        let method = HTTPMethod.get(Payload.parameters(rangeParameters))

        return Request<[Post]>(path: "/content/blurbs/home", method: method, parse: Request<[Post]>.parser)
    }

    /// Retrieves the global timeline.
    ///
    /// - Parameter range: The bounds used when requesting data from Pnut.io.
    /// - Returns: Request for `[Post]`.
    public static func global(range : RequestRange = .default) -> Request<[Post]> {
        let rangeParameters = range.parameters(limit: between(1, and: 40, fallback: 20))
        let method = HTTPMethod.get(Payload.parameters(rangeParameters))

        return Request<[Post]>(path: "/content/blurbs/global", method: method, parse: Request<[Post]>.parser)
    }
    
}
