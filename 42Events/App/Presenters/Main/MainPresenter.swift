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
