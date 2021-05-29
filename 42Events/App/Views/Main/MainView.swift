//
//  MainView.swift
//  42Events
//
//  Created by Nguyen Ngoc Diep on 2021/05/28.
//

import Foundation

protocol MainView {
    func onShowProgress()
    func onGetRaceEventsCompleted()
    func onError()
}
