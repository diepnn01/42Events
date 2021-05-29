//
//  UIViewController+Ext.swift
//  42Events
//
//  Created by Diep Nguyen on 29/05/2021.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    func showProgress() {
        SVProgressHUD.setForegroundColor(UIColor.colorFromHex("#EC3E49"))
        SVProgressHUD.show()
    }
    
    func dismissProgress() {
        SVProgressHUD.dismiss()
    }
}
