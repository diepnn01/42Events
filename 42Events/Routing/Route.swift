//
//  Route.swift
//  Carival
//
//  Created by Điệp Nguyễn on 8/13/18.
//  Copyright © 2018 Crystal. All rights reserved.
//

import UIKit
import Alamofire

final class Route {
	
	fileprivate(set) var method: HTTPMethod
	fileprivate(set) var path: String
	fileprivate(set) var queryParams: [String: Any]?
	fileprivate(set) var jsonParams: [String: Any]?
	
	public init(method: HTTPMethod,
                path: String,
                queryParams: [String: Any]? = nil,
                jsonParams: [String: Any]? = nil) {
		self.method = method
		self.path = path
		self.queryParams = queryParams
		self.jsonParams = jsonParams
	}
}
