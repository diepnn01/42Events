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
    
    struct Metrict {
        static let heightCellWithoutImage: CGFloat = 110
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSideMenu()
        title = eventCategory.title
        collectionView.register(UINib(nibName: EventCollectionViewCell.className,
                                      bundle: nil), forCellWithReuseIdentifier: EventCollectionViewCell.className)
    }
}

extension EventListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.className,
                                                            for: indexPath) as? EventCollectionViewCell else {
            return UICollectionViewCell()
        }
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
