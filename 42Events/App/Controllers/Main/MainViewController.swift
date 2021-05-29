//
//  ViewController.swift
//  42Events
//
//  Created by Diep Nguyen on 25/05/2021.
//

import UIKit

class MainViewController: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainPresenter!
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor.colorFromHex("#EC3E49")
        control.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        return control
    }()
    
    private lazy var headerview: MainHeaderView = {
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
        setupUI()
        presenter.getRaceEvents()
    }
    
    private func setupPresenter() {
        presenter = MainPresenter()
        presenter.attachView(view: self)
    }
    
    private func setupUI() {
        title = "Main.Title".localized
        tableView.tableHeaderView = headerview
        tableView.refreshControl = refreshControl
        tableView.registerCell(of: EventCategoryCell.self)
        tableView.registerCell(of: EventCell.self)
    }
    
    private func openListEvent(_ type: EventCategoryType) {
        let eventsVC = Utils.loadController(from: "Main", of: EventListVC.self)
        eventsVC.eventCategory = type
        navigationController?.pushViewController(eventsVC, animated: true)
    }
    
    @objc private func refreshData() {
        presenter.getRaceEvents()
    }
}

extension MainViewController: MainView {
    
    func onShowProgress() {
        showProgress()
    }
    
    func onGetRaceEventsCompleted() {
        dismissProgress()
        headerview.reloadData(presenter.raceEventCollection.featured)
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func onError() {
        //TODO: handle error
        refreshControl.endRefreshing()
        dismissProgress()
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueCell(of: EventCategoryCell.self, at: indexPath)
            cell.onSelectedIndex = { [weak self] index in
                guard let type = EventCategoryType(rawValue: index) else { return }
                self?.openListEvent(type)
            }
            return cell
        }
        
        let cell = tableView.dequeueCell(of: EventCell.self, at: indexPath)
        cell.title = RaceCategory.allCases[indexPath.row].title
        cell.reloadData(presenter.events(at: indexPath))
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

