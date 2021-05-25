//
//  DisposebagHaving.swift
//  GapoAssignment
//
//  Created by Diep Nguyen on 11/20/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import RxSwift

protocol DisposeBagHaving: class {
   var disposeBag: DisposeBag { get set }
}
