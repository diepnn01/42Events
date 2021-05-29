//
//  EventListVC.swift
//  42Events
//
//  Created by Diep Nguyen on 27/05/2021.
//

import Foundation
import RxSwift
import SnapKit

class EventListVC: BaseVC {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var medalSwitch: UISwitch!
    @IBOutlet weak var labelNumberEvents: UILabel!
    
    //MARK: Properties
    
    var eventCategory: EventCategoryType = .running
    private var viewMedal = false
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor.colorFromHex("#EC3E49")
        control.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        return control
    }()
    
    private var presenter: EventListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupUI()
        getData()
    }
    
    //MARK: Private methods
    private func setupPresenter() {
        presenter = EventListPresenter()
        presenter.attachView(self)
    }
    
    private func setupUI() {
        title = eventCategory.title
        medalSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        tableView.register(nibWithCellClass: EventTableViewCell.self)
        tableView.register(nibWithCellClass: EventMedalTableViewCell.self)
        tableView.refreshControl = refreshControl
    }
    
    private func getData() {
        presenter.filter(sportType: eventCategory)
    }
    
    @objc private func refreshData() {
        presenter.page = 0
        presenter.filter(sportType: eventCategory)
    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        viewMedal = !viewMedal
        tableView.reloadData()
    }
}

/*
 * implement EventListView
 */
extension EventListVC: EventListView {
    
    func onShowProgress() {
        showProgress()
    }
    
    func onFilterCompleted() {
        dismissProgress()
        refreshControl.endRefreshing()
        labelNumberEvents.text = "\(presenter.totalEvent) \(eventCategory.title) events".lowercased()
        tableView.reloadData()
    }
    
    func onError() {
        //TODO: handle error here
        refreshControl.endRefreshing()
        dismissProgress()
    }
}

/*
 * UICollectionViewDataSource and Delegate
 */
extension EventListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItem(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !viewMedal else {
            let cell = tableView.dequeueCell(of: EventMedalTableViewCell.self, at: indexPath)
            cell.race = presenter.item(at: indexPath)
            return cell
        }
        let cell = tableView.dequeueCell(of: EventTableViewCell.self, at: indexPath)
        cell.race = presenter.item(at: indexPath)
        return cell
    }
}

extension EventListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
