//
//  DataResponse.swift
//  Carival
//
//  Created by Điệp Nguyễn on 7/26/18.
//  Copyright © 2018 Crystal. All rights reserved.
//

import UIKit

class ServerResponseObject: CoreObject {
	var status: ServerResponseStatus?
	var isSuccess: Bool?
	required init(data: [AnyHashable: Any]?) {
		if let errorCode = data?["code"] as? String, let errorMessage = data?["message"] as? String {
			self.status = ServerResponseStatus(errorCode: errorCode, errorMessage: errorMessage)
		}
		isSuccess = data?["succeed"] as? Bool
	}
}
