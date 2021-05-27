//
//  EventCollectionViewCell.swift
//  42Events
//
//  Created by Diep Nguyen on 27/05/2021.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    var listItems = ["Running", "11 Joined", "Half marathon 21.907km", "Half marathon 21.907km", "Half marathon 21.907km"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventImageView.layer.cornerRadius = 1
        labelEventName.textColor = UIColor.colorFromHex("#333333")
        labelDuration.textColor = UIColor.colorFromHex("#333333")
        labelEventName.text = "[Test] 50 Day Running Challenge - Thailand"
        labelDuration.text = "01 Jan 2021 (23:59) - 29 Jan 2031 (23:59) GMT +8"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: TagCollectionViewCell.className, bundle: nil),
                                forCellWithReuseIdentifier: TagCollectionViewCell.className)
    }

}

extension EventCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.className, for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.title = listItems[indexPath.row]
        return cell
    }
}

extension EventCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = listItems[indexPath.row]
        var widthTitle = title.getWidthString(UIFont.metropolisMedium(ofSize: 12),
                                             mHeight: 50,
                                             maxWidth: UIScreen.main.bounds.width)
        let padding: CGFloat = 10
        widthTitle = widthTitle + padding * 2
        if widthTitle > UIScreen.main.bounds.width {
            widthTitle = UIScreen.main.bounds.width - 16
        }
        return CGSize(width: widthTitle, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
