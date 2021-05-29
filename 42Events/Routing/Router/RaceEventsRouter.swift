//
//  EventRouter.swift
//  42Events
//
//  Created by Diep Nguyen on 28/05/2021.
//

import Foundation
import Alamofire

class RaceEventsRouter: Router {
    func getRaceEvents() -> URLRequestConvertible {
        let path = buildValidFullPathForRequest("v1/race-events")
        return buildUrlRequest(Route(method: .get, path: path))
    }
}
