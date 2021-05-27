//
//  UIFont+Ext.swift
//  42Events
//
//  Created by Diep Nguyen on 27/05/2021.
//

import Foundation
import UIKit

extension UIFont {
    
    class func metropolisExtraBold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Metropolis-ExtraBold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    class func metropolisBold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Metropolis-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    class func metropolisSemiBold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Metropolis-SemiBold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    class func metropolisMedium(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Metropolis-Medium", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    class func metropolisRegular(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Metropolis-Regular", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
}
