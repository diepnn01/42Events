//
//  EventListService.swift
//  42Events
//
//  Created by Diep Nguyen on 29/05/2021.
//

import Foundation
import Alamofire

class RaceFilterService {
    let router = RaceFilterRouter()
    
    func filterRaces(sportType: String, maxItem: Int = 10, skipCount: Int = 0) -> ServiceRequest<FilterRaceCollection> {
        let request = ServiceRequest<FilterRaceCollection>()
        AF.request(router.filterRaces(sportType: sportType,
                                      maxItem: maxItem,
                                      skipCount: skipCount)).responseJSON { (response) in
            request.handleResponseJSON(response: response)
        }
        return request
    }
}
