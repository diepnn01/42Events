//
//  ViewController.swift
//  42Events
//
//  Created by Diep Nguyen on 25/05/2021.
//

import UIKit

class MainViewController: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var headerview: MainHeaderView = {
        let view = MainHeaderView(shouldSetup: true)
        let screenWidth = UIScreen.main.bounds.width
        let height = screenWidth * 9/16
        view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: height)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.tableHeaderView = headerview
        tableView.registerCell(of: EventCategoryCell.self)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueCell(of: EventCategoryCell.self, at: indexPath)
            return cell
        }
        return UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

