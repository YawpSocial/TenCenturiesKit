import Foundation


public struct Authentication {

    /// Logs the user in.
    ///
    /// - Parameters:
    ///   - clientID: The client ID.
    ///   - username: The user's username or e-mail address.
    ///   - password: The user's password.
    /// - Returns: Request for `LoginSettings`.
    public static func login(clientID: String, username: String, password: String) -> Request<LoginResponse> {
        let parameters = [
            Parameter(name: "client_guid", value: clientID),
            Parameter(name: "acctname", value: username),
            Parameter(name: "acctpass", value: password)
        ]

        let method = HTTPMethod.post(Payload.parameters(parameters))
        return Request<LoginResponse>(path: "/auth/login", method: method, parse: Request<LoginResponse>.parser)
    }

    public static func status() -> Request<StatusResponse> {
        let method = HTTPMethod.get(Payload.empty)
        return Request<StatusResponse>(path: "/auth/status", method: method, parse: Request<StatusResponse>.parser)
    }

    public static func logout() -> Request<LogoutResponse> {
        let method = HTTPMethod.post(Payload.empty)
        return Request<LogoutResponse>(path: "/auth/logout", method: method, parse: Request<LogoutResponse>.parser)
    }

}
