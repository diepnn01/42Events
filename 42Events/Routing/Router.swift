//
//  Router.swift
//  Carival
//
//  Created by Diep Nguyen on 7/25/18.
//  Copyright © 2018 Crystal. All rights reserved.
//

import UIKit
import Alamofire

enum Environment {
	case development
	case staging
	case production
}

class Router {
	
	static var environment: Environment {
		#if DEV
		return .development
		#elseif STAGING
		return .staging
		#else
		return .production
		#endif
	}

	static private(set) var host: String = "https://api-v2-sg-staging.42race.com"
        
	static var baseUrl: String {
		switch environment {
		case .development:
			host = "https://api-v2-sg-staging.42race.com"
		case .staging:
			host = "https://api-v2-sg-staging.42race.com"
		case .production:
			host = "https://api-v2-sg-staging.42race.com"
		}
		return "\(host)/api"
	}
	
	static func setHost(endpoint: String) {
		host = endpoint
	}

	func buildUrlRequest(_ route: Route) -> URLRequestConvertible {
		return RouterUrlConvertible(route: route)
	}
	
	func buildValidFullPathForRequest(_ path: String) -> String {
		if let url = URL(string: Router.baseUrl) {
			return url.appendingPathComponent(path).absoluteString
		}
		return path
	}
}
