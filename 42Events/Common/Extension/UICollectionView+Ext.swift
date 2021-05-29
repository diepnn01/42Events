//
//  UICollectionView+Ext.swift
//  42Events
//
//  Created by Diep Nguyen on 29/05/2021.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func dequeueCell<T>(of type: T.Type, at indexPath: IndexPath, with identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: type.self)
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("\(identifier) is nil")
        }
        return cell
    }
}
