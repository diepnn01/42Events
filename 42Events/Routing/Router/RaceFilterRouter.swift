//
//  RaceFilterRouter.swift
//  42Events
//
//  Created by Diep Nguyen on 28/05/2021.
//

import Foundation
import Alamofire

class RaceFilterRouter: Router {
 
    func filterRaces(sportType: String, maxItem: Int = 10, skipCount: Int = 0) -> URLRequestConvertible {
        let path = buildValidFullPathForRequest("v1/race-filters")
        let params: [String: Any] = ["skipCount": skipCount,
                                     "limit": maxItem,
                                     "sportType": sportType]
        return buildUrlRequest(Route(method: .get,
                                     path: path,
                                     queryParams: params))
    }
}
