//
//  UIColor+Extention.swift
//  BCAInvestment
//
//  Created by Điệp Nguyễn on 1/21/18.
//  Copyright © 2018 BCA. All rights reserved.
//
import Foundation
import UIKit

extension UIColor {
    
    static func colorFromHex(_ hex: String) -> UIColor {
        var cString = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#") == true) {
            cString = (cString as NSString).substring(from: 1)
        }
        if (cString.count != 6) {
            return UIColor.gray
        }
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var red: CUnsignedInt = 0,
            green: CUnsignedInt = 0,
            blue: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&red)
        Scanner(string: gString).scanHexInt32(&green)
        Scanner(string: bString).scanHexInt32(&blue)
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(1))
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }
    
    convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let alpha   = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let red     = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let green   = CGFloat((hex8 & 0x0000FF00) >> 8) / divisor
        let blue    = CGFloat(hex8 & 0x000000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
