//
//  EventListView.swift
//  42Events
//
//  Created by Nguyen Ngoc Diep on 2021/05/28.
//

import Foundation

protocol EventListView {
    func onShowProgress()
    func onFilterCompleted()
    func onError()
}
