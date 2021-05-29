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
    
    @IBOutlet weak var collectionView: UICollectionView!
    var eventCategory: EventCategoryType = .running
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor.colorFromHex("#EC3E49")
        control.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        return control
    }()
    
    struct Metrict {
        static let heightCellWithoutImage: CGFloat = 110
    }
    
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
        collectionView.register(UINib(nibName: EventCollectionViewCell.className,
                                      bundle: nil), forCellWithReuseIdentifier: EventCollectionViewCell.className)
        collectionView.refreshControl = refreshControl
    }
    
    private func getData() {
        presenter.filter(sportType: eventCategory)
    }
    
    @objc private func refreshData() {
        presenter.page = 0
        presenter.filter(sportType: eventCategory)
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
        collectionView.reloadData()
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
extension EventListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItem(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(of: EventCollectionViewCell.self, at: indexPath)
        cell.race = presenter.item(at: indexPath)
        return cell
    }
}

extension EventListVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageBGHeight = (UIScreen.main.bounds.width) * 9/16
        let collectionHeight = imageBGHeight + Metrict.heightCellWithoutImage
        return CGSize(width: UIScreen.main.bounds.width,
                      height: collectionHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
