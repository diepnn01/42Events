//
//  StringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation

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
