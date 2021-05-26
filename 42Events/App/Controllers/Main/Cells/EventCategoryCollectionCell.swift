//
//  EventCategoryCollectionCell.swift
//  42Events
//
//  Created by Diep Nguyen on 26/05/2021.
//

import UIKit
import RxSwift
import SnapKit

class EventCategoryCollectionCell: UICollectionViewCell, BaseViewType {
    
    var disposeBag = DisposeBag()
    
    lazy private var containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy private var imageViewBg: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    
    lazy private var labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.addSubview(containerView)
        [imageViewBg, labelTitle].forEach(containerView.addSubview)
        containerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
        }
        imageViewBg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        labelTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func bind() {
        //
    }
    
    var type: EventCategoryType? {
        didSet {
            guard let type = type else {
                return
            }
            containerView.backgroundColor = type.bgColor
            
            let url = URL(string: type.linkBg)
            imageViewBg.kf.setImage(with: url)
            
            labelTitle.text = type.title
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
