//
//  GlobalFunctions.swift
//  PerfectTemplate
//
//  Created by NTQ on 12/3/18.
//

import Foundation
import PerfectHTTP

public func GFResponse<T: Encodable>(_ response: HTTPResponse, body: T?) {

    // Respond with a simple message.
    response.setHeader(.contentType, value: "application/json")

    let data: [UInt8] = {
        do {
            let response = CommonResponse<T>(message: "OK", body: body)
            return [UInt8](try JSONEncoder().encode(response))
        }
        catch {
            let response = CommonResponse<String>(message: "NOK", body: error.localizedDescription)
            return [UInt8]((try? JSONEncoder().encode(response)) ?? Data(capacity: 0))
        }
    }()

    response.appendBody(bytes: data)

    // Ensure that response.completed() is called when your processing is done.
    response.completed()
}

private struct CommonResponse<T: Encodable>: Encodable {
    var message: String
    var body: T?
}
