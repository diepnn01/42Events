//
//  NSObjectExtension.swift
//  Drjoy
//
//  Created by Diep Nguyen on 3/5/20.
//  Copyright © 2020 Dr.JOY No,054. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    var className: String {
        
        return String(describing: type(of: self))
    }
    
    class var className: String {
        
        return String(describing: self)
    }
}
