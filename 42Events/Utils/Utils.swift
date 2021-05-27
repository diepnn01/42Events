//
//  Utils.swift
//  42Events
//
//  Created by Diep Nguyen on 27/05/2021.
//

import Foundation
import UIKit

class Utils {
    static let shared = Utils()
    
    static func loadController<T>(from storyboard: String, of type: T.Type, with identifier: String? = nil) -> T {
        let storybroad = UIStoryboard(name: storyboard, bundle: Bundle.main)
        let identifier = identifier ?? String(describing: type.self)
        guard let vc = storybroad.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Cannot found viewcontroller with \(identifier)")
        }
        return vc
    }
}
