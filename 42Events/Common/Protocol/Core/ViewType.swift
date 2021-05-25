//
//  ViewType.swift
//  GapoAssignment
//
//  Created by Diep Nguyen on 11/20/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit
import RxSwift

typealias BaseViewType = ViewType & Layoutable & Bindable & DisposeBagHaving

protocol ViewType: class {
   func setup()
}

extension ViewType {
   func setup() {
      (self as? Layoutable)?.layout()
      (self as? Bindable)?.bind()
   }
}

extension ViewType where Self: UIView {
   init(shouldSetup: Bool) {
      self.init(frame: .zero)

      if shouldSetup {
         self.setup()
      }
   }
}
