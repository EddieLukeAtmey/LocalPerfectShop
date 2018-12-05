//
//  UserRoute.swift
//  LocalPerfectShop
//
//  Created by NTQ on 12/4/18.
//

import Foundation
import PerfectHTTP

struct UserRoute: PFRouteConvertible {
    static var routes: [Route] = {
        var routes = [Route]()
        routes.append(Route(method: .get, uri: "/user", handler: handler))
        return routes
    }()

    private static func handler(request: HTTPRequest, response: HTTPResponse) {
//        let u = User(user_name: "2", age: 24.5, nickName: nil, gender: 0)
        let u = ["2",
                 "24.5"]
        GFResponse(response, body: u)

    }
}

private struct User: Encodable {
    var user_name: String
    var age: Float
    var nickName: String?
    var gender: Int?

    private enum CodingKeys: String, CodingKey {
        case username = "user_name"
        case nickName , age , gender , weight , money , dob
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeNil(forKey: .nickName)
        try container.encode(user_name, forKey: .username)
        try container.encode(age, forKey: .age)
    }
}
