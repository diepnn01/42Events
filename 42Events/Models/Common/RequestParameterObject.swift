//
//  RequestParameterObject.swift
//  Carival
//
//  Created by Điệp Nguyễn on 9/4/18.
//  Copyright © 2018 Crystal. All rights reserved.
//

import UIKit

protocol RequestParameterObject {

	func toJsonParams() -> [String: Any]
}
