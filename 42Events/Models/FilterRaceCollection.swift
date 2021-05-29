//
//  FilterRaceCollection.swift
//  42Events
//
//  Created by Diep Nguyen on 29/05/2021.
//

import Foundation

struct FilterRaceCollection: CoreObject {
    
    var races = [Race]()
    var totalData: Int = 0
    var totalPagination: Int = 0
    var cachedData = false
    
    init(data: [AnyHashable: Any]?) {
        if let objects = data?["data"] as? [[AnyHashable: Any]] {
            races = objects.map({ Race(data: $0) })
        }
        if let count = data?["totalData"] as? Int {
            totalData = count
        }
        if let count = data?["totalPagination"] as? Int {
            totalPagination = count
        }
        if let cached = data?["cachedData"] as? Bool {
            cachedData = cached
        }
    }
}
