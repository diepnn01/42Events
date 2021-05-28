//
//  SideMenuView.swift
//  42Events
//
//  Created by Nguyen Ngoc Diep on 2021/05/28.
//

import UIKit
import RxSwift
import SnapKit

enum SideMenuItemType: Int, CaseIterable {
    case login
    case signUp
    case guidesAndFAQ
    case contactUs
    case language

    var title: String {
        switch self {
        case .login: return "Login"
        case .signUp: return "Sign up"
        case .guidesAndFAQ: return "Guides and FAQ"
        case .contactUs: return "Contact us"
        case .language: return "Language"
        }
    }

    var iconLeft: UIImage {
        switch self {
        case .login: return UIImage(imageLiteralResourceName: "sidemenu_order")
        case .signUp: return UIImage(imageLiteralResourceName: "sidemenu_edit")
        case .guidesAndFAQ: return UIImage(imageLiteralResourceName: "sidemenu_guides")
        case .contactUs: return UIImage(imageLiteralResourceName: "sidemenu_contact-us")
        case .language: return UIImage(imageLiteralResourceName: "sidemenu_change-language")
        }
    }
}


class SideMenuView: UIView, BaseViewType {

    var disposeBag = DisposeBag()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(of: SideMenuCell.self)
        return tableView
    }()

    func layout() {
        [tableView].forEach(addSubview)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func bind() {}
}

extension SideMenuView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideMenuItemType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(of: SideMenuCell.self, at: indexPath)
        let item = SideMenuItemType.allCases[indexPath.row]
        cell.item = item
        if item == .language {
            cell.value = "English"
        } else {
            cell.value = ""
        }
        return cell
    }
}

extension SideMenuView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
