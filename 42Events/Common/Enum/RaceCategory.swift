//
//  RaceCategory.swift
//  42Events
//
//  Created by Diep Nguyen on 29/05/2021.
//

import Foundation

enum RaceCategory: Int, CaseIterable {
    case startSoon
    case popular
    case newRelease
    case free
    case past
    
    var title: String? {
        switch self {
        case .startSoon: return "RaceCategory.StartingSoon".localized
        case .popular: return "RaceCategory.Popular".localized
        case .newRelease: return "RaceCategory.NewRelease".localized
        case .free: return "RaceCategory.Free".localized
        case .past: return "RaceCategory.PastEvents".localized
        }
    }
}
