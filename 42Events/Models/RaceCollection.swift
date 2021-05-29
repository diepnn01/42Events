//
//  RaceCollection.swift
//  42Events
//
//  Created by Diep Nguyen on 28/05/2021.
//

import Foundation

class RaceCollection: CoreObject {
    var featured = [Race]()
    var startingSoon = [Race]()
    var popular = [Race]()
    var newRelease = [Race]()
    var free = [Race]()
    var past = [Race]()
    
    required init(data: [AnyHashable: Any]?) {
        guard let data = data?["data"] as? [AnyHashable: Any] else {
            return
        }
        if let objects = data["featured"] as? [[AnyHashable: Any]] {
            featured = objects.map({ Race(data: $0) })
        }
        if let objects = data["startingSoon"] as? [[AnyHashable: Any]] {
            startingSoon = objects.map({ Race(data: $0) })
        }
        if let objects = data["popular"] as? [[AnyHashable: Any]] {
            popular = objects.map({ Race(data: $0) })
        }
        if let objects = data["newRelease"] as? [[AnyHashable: Any]] {
            newRelease = objects.map({ Race(data: $0) })
        }
        if let objects = data["free"] as? [[AnyHashable: Any]] {
            free = objects.map({ Race(data: $0) })
        }
        if let objects = data["past"] as? [[AnyHashable: Any]] {
            past = objects.map({ Race(data: $0) })
        }
    }
}
