//
//  MainPresenter.swift
//  42Events
//
//  Created by Nguyen Ngoc Diep on 2021/05/28.
//

import Foundation

class MainPresenter {
    
    var service: MainService!
    var view: MainView?
    
    var raceEventCollection = RaceCollection(data: nil)
    
    init() {
        service = MainService()
    }
    
    func attachView(view: MainView) {
        self.view = view
    }
    
    func getRaceEvents() {
        service.getRaceEvents().cloudResponse { [weak self](collection) in
            self?.raceEventCollection = collection
            self?.view?.getRaceEventsCompleted()
        }.cloudError { (errorMsg, _) in
            print("error")
        }
    }
}

extension MainPresenter {
    
    func numberOfRows(at section: Int) -> Int {
        return section == 0 ? 1 : RaceCategory.allCases.count
    }
    
    func events(at indexPath: IndexPath) -> [Race] {
        guard let raceType = RaceCategory(rawValue: indexPath.row) else {
            return []
        }
        switch raceType {
        case .startSoon: return raceEventCollection.startingSoon
        case .popular: return raceEventCollection.popular
        case .newRelease: return raceEventCollection.newRelease
        case .free: return raceEventCollection.free
        case .past: return raceEventCollection.past
        }
    }
}
