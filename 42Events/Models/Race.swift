//
//  Race.swift
//  42Events
//
//  Created by Diep Nguyen on 28/05/2021.
//

import Foundation

struct Race: CoreObject {
    var id: String = ""
    var raceIDs = [String]()
    var raceName: String?
    var startDate: String?
    var endDate: String?
    var raceType: String?
    var sportType: String?
    var medalEngravingEndDate: String?
    var raceRunners: Int = 0
    var launchDate: String?
    var isNew: Bool = false
    var isFreeEngraving: Bool = false
    var racePeriod: String?
    var categories = [String]()
    var racePrice: String?
    var eventType: String?
    var bannerCard: String?
    var medalViewImage: String?
    var isBundle: Bool = false
    var isBrandRace: Bool = false
    var joined: Bool = false
    
    init(data: [AnyHashable: Any]?) {
        if let id = data?["_id"] as? String {
            self.id = id
        }
        
        if let raceIDs = data?["raceIDs"] as? [String] {
            self.raceIDs = raceIDs
        }
        raceName = data?["race_name"] as? String
        startDate = data?["start_date"] as? String
        endDate = data?["end_date"] as? String
        raceType = data?["race_type"] as? String
        sportType = data?["sportType"] as? String
        medalEngravingEndDate = data?["medal_engraving_end_date"] as? String
        if let raceRunners = data?["raceRunners"] as? Int {
            self.raceRunners = raceRunners
        }
        launchDate = data?["launch_date"] as? String
        if let isNew = data?["is_new"] as? Bool {
            self.isNew = isNew
        }
        if let isFreeEngraving = data?["isFreeEngraving"] as? Bool {
            self.isFreeEngraving = isFreeEngraving
        }
        racePeriod = data?["racePeriod"] as? String
        if let categories = data?["categories"] as? [String] {
            self.categories = categories
        }
        racePrice = data?["racePrice"] as? String
        eventType = data?["eventType"] as? String
        bannerCard = data?["banner_card"] as? String
        medalViewImage = data?["medalViewImage"] as? String
        if let isBundle = data?["isBundle"] as? Bool {
            self.isBundle = isBundle
        }
        if let isBrandRace = data?["is_brand_race"] as? Bool {
            self.isBrandRace = isBrandRace
        }
        if let joined = data?["joined"] as? Bool {
            self.joined = joined
        }
    }
}
