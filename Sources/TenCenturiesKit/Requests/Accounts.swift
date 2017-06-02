import Foundation


public struct Accounts {

    public static func account(id : Int) -> Request<[Account]> {
        let method = HTTPMethod.get(Payload.empty)

        return Request<[Account]>(path: "/users/\(id)", method: method, parse: Request<[Account]>.parser)
    }

//    public static func blurbs(id : Int) -> Request<Account> {
//        let method = HTTPMethod.get(Payload.empty)
//
//        return Request<Account>(path: "/users/blurbs/\(id)", method: method, parse: Request<Account>.parser)
//    }

}
