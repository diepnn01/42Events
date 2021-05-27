//
//  StringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Localized
public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    /// Load the localized string with additional arguments
    /// - Parameter arguments: The list arguments
    /// - Returns: The localized string with the arguments
    func localizedWithFormat(_ arguments: [CVarArg]) -> String {
        let localizedString = String(format: localized, arguments: arguments)
        return localizedString
    }
}

extension String {
    func getWidthString(_ font: UIFont, mHeight: CGFloat, maxWidth: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: maxWidth, height: mHeight)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return boundingBox.width
    }
    
    func getHeightString(_ font: UIFont, maxHeight: CGFloat, mWidth: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: mWidth, height: maxHeight)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return boundingBox.height
    }
}
