//
//  ServiceRequest.swift
//  Carival
//
//  Created by Điệp Nguyễn on 7/25/18.
//  Copyright © 2018 Crystal. All rights reserved.
//

import UIKit
import Alamofire

final class ServiceRequest<T: CoreObject> {
	private var cloudResponseClosure: ((T) -> Void)?
	private var cloudErrorClosure: ((_ status: String, _ code: Int?) -> Void)?
	private var finallyClosure: (() -> Void)?
	var cachedResult: T!
	public init() {
		self.cloudResponseClosure = nil
		self.cloudErrorClosure = nil
	}
	@discardableResult
	func cloudResponse(_ closure: ((T) -> Void)? = nil) -> Self {
		self.cloudResponseClosure = closure
		return self
	}
	@discardableResult
	func cloudError(_ closure: ((_ status: String, _ code: Int?) -> Void)? = nil) -> Self {
		self.cloudErrorClosure = closure
		return self
	}
	@discardableResult
	func finally(_ closure: (() -> Void)?) -> Self {
		self.finallyClosure = closure
		return self
	}
	func handleResponseJSON(response: AFDataResponse<Any>) {
        defer {
            finallyClosure?()
        }
        guard response.error == nil else {
            handleError(error: response.error)
            return
        }
		let result = response.value as? [String: Any]
        guard let statusCode = response.response?.statusCode, statusCode == 200 else {
            // TODO: revisit to change error message
            guard let statusCode = response.response?.statusCode, statusCode != 405 else {
                // login other device
                let message = result?["message"] as? String
                showPopupSessionExpired(message: message)
                return
            }
			guard let statusCodeExpire = response.response?.statusCode, statusCodeExpire != 406 else {
                // session expire
				let message = result?["message"] as? String
				showPopupSessionExpired(message: message)
				return
			}
			if let message = result?["message"] as? String {
				cloudErrorClosure?(message, response.response?.statusCode)
				return
			}
            cloudErrorClosure?("Error from server", 500)
            return
        }
        let obj = T(data: result)
        cloudResponseClosure?(obj)
    }
	private func showPopupSessionExpired(message: String?) {
//		Spinner.shared.dismiss()
//		guard let topVC = UIApplication.topViewController(), !(topVC is InitialViewController) else {
//			return
//		}
//
//		CommonAlert.show(title: ((message ?? "Session Expired")), touchOutside: false, firstButtonAction: {
//            Spinner.shared.show()
//            CartManager.shared.removeItems()
//            let service = UserService()
//            service.logout().cloudResponse { [weak self] (response) in
//                SessionManager.shared.clearData()
//                NotificationCenter.default.post(name: .sessionExpire, object: nil)
//                NotificationCenter.default.post(name: .logout, object: nil)
//                }.cloudError { [weak self] (error: String, _: Int?) in
//                }.finally {
//                    Spinner.shared.dismiss()
//            }
//		})
	}
	func handleError(error: Error?) {
		guard let error = error else {
			// TODO: revisit to change error message
			cloudErrorClosure?("Error from server", 500)
			return
		}
		cloudErrorClosure?(error.localizedDescription, 500)
	}
}
