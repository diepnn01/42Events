//
//  SideMenuCellTableViewCell.swift
//  42Events
//
//  Created by Nguyen Ngoc Diep on 2021/05/28.
//

import UIKit
import RxSwift
import SnapKit

class SideMenuCell: UITableViewCell, BaseViewType {

    var disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var iconLeft: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()

    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.metropolisMedium(ofSize: 14)
        return label
    }()

    private lazy var labelValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.metropolisMedium(ofSize: 14)
        return label
    }()

    private lazy var iconArrowRight: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(imageLiteralResourceName: "arrow_right")
        return imgView
    }()

    var item: SideMenuItemType? {
        didSet {
            guard let item = item else { return }
            iconLeft.image = item.iconLeft
            labelTitle.text = item.title
        }
    }

    var value: String? {
        didSet {
            labelValue.text = value
        }
    }

    func layout() {
        selectionStyle = .none
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.colorFromHex("#E6E6E6")
        [iconLeft, labelTitle, labelValue, iconArrowRight, separatorLine].forEach(contentView.addSubview)

        iconLeft.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(25)
        }

        labelTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(iconLeft.snp.trailing).offset(8)
            make.trailing.equalTo(labelValue.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }

        labelValue.snp.makeConstraints { (make) in
            make.trailing.equalTo(iconArrowRight.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }

        iconArrowRight.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(12)
        }

        separatorLine.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }

    }

    func bind() {
        //
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
