//
//  MainService.swift
//  42Events
//
//  Created by Diep Nguyen on 28/05/2021.
//

import Foundation
import Alamofire

final class MainService {
    let router = RaceEventsRouter()
    
    func getRaceEvents() -> ServiceRequest<RaceCollection> {
        let request = ServiceRequest<RaceCollection>()
        AF.request(router.getRaceEvents()).responseJSON { (response) in
            request.handleResponseJSON(response: response)
        }
        return request
    }
}
