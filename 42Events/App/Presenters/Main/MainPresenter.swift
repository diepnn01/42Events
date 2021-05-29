//
//  MainPresenter.swift
//  42Events
//
//  Created by Nguyen Ngoc Diep on 2021/05/28.
//

import Foundation

class MainPresenter {
    
    var view: MainView?
    
    //MARK: Private properties
    private var service: MainService!
    private var isLoading = false
    
    //MARK: Public properties
    var raceEventCollection = RaceCollection(data: nil)
    
    //MARK: Initialize
    init() {
        service = MainService()
    }
    
    func attachView(view: MainView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    //MARK: Get data from API
    func getRaceEvents() {
        guard !isLoading else { return }
        isLoading = true
        view?.onShowProgress()
        service.getRaceEvents().cloudResponse { [weak self](collection) in
            self?.raceEventCollection = collection
            self?.view?.onGetRaceEventsCompleted()
            self?.isLoading = false
        }.cloudError { [weak self](errorMsg, _) in
            self?.view?.onError()
            self?.isLoading = false
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
