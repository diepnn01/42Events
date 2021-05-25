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
        tableView.tableHeaderView = headerview
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

