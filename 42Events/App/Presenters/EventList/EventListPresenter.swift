//
//  EventListPresenter.swift
//  42Events
//
//  Created by Nguyen Ngoc Diep on 2021/05/28.
//

import Foundation

class EventListPresenter {
    var view: EventListView?
    
    //MARK: Private properties
    private let service: RaceFilterService!
    private var datasource = [Race]()
    private var totalItems = 0
    private var isLoading = false
    private let maxItemPerPage = 10
    
    //MARK: Public properties
    var page = 0
    
    var totalEvent: Int {
        return datasource.count
    }
    
    //MARK: Inititalization
    init() {
        service = RaceFilterService()
    }
    
    func attachView(_ view: EventListView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    //MARK: Get Data
    func filter(sportType: EventCategoryType) {
        guard !isLoading else { return }
        isLoading = true
        view?.onShowProgress()
        service.filterRaces(sportType: sportType.paramFilter,
                            maxItem: maxItemPerPage,
                            skipCount: page)
            .cloudResponse { [weak self](collection) in
                self?.datasource = collection.races
                self?.totalItems = collection.totalData
                self?.view?.onFilterCompleted()
                self?.isLoading = false
            }.cloudError { [weak self](errorMsg, _) in
                self?.view?.onError()
                self?.isLoading = false
            }
    }
}

extension EventListPresenter {
    
    func numberOfItem(at section: Int) -> Int {
        return datasource.count
    }
    
    func item(at indexPath: IndexPath) -> Race? {
        guard indexPath.row >= 0 && indexPath.row < datasource.count  else {
            return nil
        }
        return datasource[indexPath.row]
    }
}
