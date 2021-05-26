//
//  UIFont+Ext.swift
//  42Events
//
//  Created by Diep Nguyen on 27/05/2021.
//

import Foundation
import UIKit

extension UIFont {
    
    class func metropolisBold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Metropolis-ExtraBold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
}
