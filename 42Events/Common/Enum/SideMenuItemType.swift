//
//  SideMenuItemType.swift
//  42Events
//
//  Created by Diep Nguyen on 29/05/2021.
//

import Foundation
import UIKit

enum SideMenuItemType: Int, CaseIterable {
    case login
    case signUp
    case guidesAndFAQ
    case contactUs
    case language
    
    var title: String {
        switch self {
        case .login: return "SideMenuItemType.Login".localized
        case .signUp: return "SideMenuItemType.Signup".localized
        case .guidesAndFAQ: return "SideMenuItemType.GuidesAndFAQ".localized
        case .contactUs: return "SideMenuItemType.ContactUs".localized
        case .language: return "SideMenuItemType.Language".localized
        }
    }
    
    var iconLeft: UIImage {
        switch self {
        case .login: return UIImage(imageLiteralResourceName: "sidemenu_order")
        case .signUp: return UIImage(imageLiteralResourceName: "sidemenu_edit")
        case .guidesAndFAQ: return UIImage(imageLiteralResourceName: "sidemenu_guides")
        case .contactUs: return UIImage(imageLiteralResourceName: "sidemenu_contact-us")
        case .language: return UIImage(imageLiteralResourceName: "sidemenu_change-language")
        }
    }
}
