//
//  ViewController.swift
//  42Events
//
//  Created by Diep Nguyen on 25/05/2021.
//

import UIKit

class MainViewController: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var sections = ["Starting soon", "Popular", "New Releasees", "Free", "Past Events"]
    
    lazy var headerview: MainHeaderView = {
        let view = MainHeaderView(shouldSetup: true)
        let screenWidth = UIScreen.main.bounds.width
        let height = screenWidth * 9/16
        view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: height)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSideMenu()
        title = "Main.Title".localized
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.tableHeaderView = headerview
        tableView.registerCell(of: EventCategoryCell.self)
        tableView.registerCell(of: EventCell.self)
    }
    
    private func openListEvent(_ type: EventCategoryType) {
        let eventsVC = Utils.loadController(from: "Main", of: EventListVC.self)
        eventsVC.eventCategory = type
        self.navigationController?.pushViewController(eventsVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueCell(of: EventCategoryCell.self, at: indexPath)
            cell.onSelectedIndex = { [weak self] index in
                guard let type = EventCategoryType(rawValue: index) else {
                    return
                }
                self?.openListEvent(type)
            }
            return cell
        }
        let cell = tableView.dequeueCell(of: EventCell.self, at: indexPath)
        cell.title = sections[indexPath.row]
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

