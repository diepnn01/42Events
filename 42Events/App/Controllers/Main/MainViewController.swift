//
//  ViewController.swift
//  42Events
//
//  Created by Diep Nguyen on 25/05/2021.
//

import UIKit

enum RaceCategory: Int, CaseIterable {
    case startSoon
    case popular
    case newRelease
    case free
    case past
    
    var title: String? {
        switch self {
        case .startSoon: return "Starting Soon"
        case .popular: return "Popular"
        case .newRelease: return "New Release"
        case .free: return "Free"
        case .past: return "Past Events"
        }
    }
}

class MainViewController: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainPresenter!
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
        setupPresenter()
        title = "Main.Title".localized
        setupTableView()
        presenter.getRaceEvents()
    }
    
    private func setupPresenter() {
        presenter = MainPresenter()
        presenter.attachView(view: self)
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

extension MainViewController: MainView {
    
    func getRaceEventsCompleted() {
        headerview.reloadData(presenter.raceEventCollection.featured)
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : RaceCategory.allCases.count
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
        cell.title = RaceCategory.allCases[indexPath.row].title
        let raceType = RaceCategory(rawValue: indexPath.row) ?? .startSoon
        switch raceType {
        case .startSoon:
            cell.reloadData(presenter.raceEventCollection.startingSoon)
        case .popular:
            cell.reloadData(presenter.raceEventCollection.popular)
        case .newRelease:
            cell.reloadData(presenter.raceEventCollection.newRelease)
        case .free:
            cell.reloadData(presenter.raceEventCollection.newRelease)
        case .past:
            cell.reloadData(presenter.raceEventCollection.past)
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

