//
//  TagCollectionViewCell.swift
//  42Events
//
//  Created by Diep Nguyen on 27/05/2021.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.cornerRadius = 12
        viewContainer.layer.masksToBounds = true
        viewContainer.layer.borderWidth = 1
        viewContainer.layer.borderColor = UIColor.colorFromHex("#E6E6E6").cgColor
        labelTitle.textColor = UIColor.colorFromHex("#333333")
    }

    var title: String? {
        didSet {
            labelTitle.text = title
        }
    }
}
