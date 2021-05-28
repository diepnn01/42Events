//
//  BaseVC.swift
//  42Events
//
//  Created by Diep Nguyen on 25/05/2021.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class BaseVC: UIViewController {

    var isOpeningSideMenu = false
    let disposeBag = DisposeBag()
    lazy var sideMenuView: SideMenuView = {
        let sideMenuView = SideMenuView(shouldSetup: true)
        return sideMenuView
    }()

    private lazy var hamburgerButton: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_hamburger"), for: .normal)
        button.addTarget(self, action: #selector(self.toogle), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func addSideMenu() {
        navigationItem.rightBarButtonItem = hamburgerButton
        view.addSubview(sideMenuView)
        view.bringSubviewToFront(sideMenuView)

        let screenWidth = UIScreen.main.bounds.width
        sideMenuView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(screenWidth)
            make.trailing.equalToSuperview().offset(screenWidth)
            make.top.bottom.equalToSuperview()
        }
    }
}

/*
 * Declare private funcs
 */
extension BaseVC {

    @objc private func toogle() {
        isOpeningSideMenu = !isOpeningSideMenu
        let screenWidth = UIScreen.main.bounds.width
        let contraints = isOpeningSideMenu ? 0 : screenWidth


        UIView.animate(withDuration: 0.3) {
            self.sideMenuView.snp.updateConstraints { (make) in
                make.leading.equalToSuperview().offset(contraints)
                make.trailing.equalToSuperview().offset(contraints)
            }
            self.view.layoutIfNeeded()
        }
    }
}
