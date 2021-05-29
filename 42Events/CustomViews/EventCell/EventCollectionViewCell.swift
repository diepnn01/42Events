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
    @IBOutlet weak var freeMedalEngraving: UIView!

    private var categories = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        freeMedalEngraving.backgroundColor = UIColor.colorFromHex("#eb3d49")
        freeMedalEngraving.layer.cornerRadius = 12
        freeMedalEngraving.layer.masksToBounds = true
        
        eventImageView.layer.cornerRadius = 1
        labelEventName.textColor = UIColor.colorFromHex("#333333")
        labelDuration.textColor = UIColor.colorFromHex("#333333")
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: TagCollectionViewCell.className, bundle: nil),
                                forCellWithReuseIdentifier: TagCollectionViewCell.className)
    }

    var race: Race? {
        didSet {
            guard let race = race else { return }
            freeMedalEngraving.isHidden = !race.isFreeEngraving
            let url = URL(string: race.bannerCard ?? "")
            eventImageView.kf.setImage(with: url, placeholder: UIImage(named: "Default_Banner"))
            labelEventName.text = race.raceName
            labelDuration.text = race.racePeriod
            categories = race.categories
            collectionView.reloadData()
        }
    }
}

extension EventCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.className, for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.title = categories[indexPath.row]
        return cell
    }
}

extension EventCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = categories[indexPath.row]
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
