//
//  HeaderCarouselCell.swift
//  42Events
//
//  Created by Diep Nguyen on 26/05/2021.
//

import UIKit
import RxSwift
import Kingfisher
import SnapKit

class HeaderCarouselCell: UICollectionViewCell, BaseViewType {
    
    var disposeBag = DisposeBag()
    
    lazy var imvBG: UIImageView = {
        let imv = UIImageView()
        return imv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        [imvBG].forEach(contentView.addSubview)
        imvBG.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    var imageUrl: String? {
        didSet {
            guard let imageUrl = imageUrl else { return }
            let url = URL(string: imageUrl)
            imvBG.kf.setImage(with: url)
        }
    }
    
    func bind() {}
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
