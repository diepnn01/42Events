//
//  EventCell.swift
//  42Events
//
//  Created by Diep Nguyen on 27/05/2021.
//

import UIKit
import RxSwift
import SnapKit

class EventCell: UITableViewCell, BaseViewType {

    var disposeBag = DisposeBag()
    
    lazy private var labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.metropolisBold(ofSize: 18)
        return label
    }()
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: EventCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: EventCollectionViewCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String? {
        didSet {
            labelTitle.text = title
        }
    }
    
    func layout() {
        selectionStyle = .none
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.colorFromHex("#E6E6E6")
        
        [labelTitle, collectionView, separatorLine].forEach(contentView.addSubview)
        
        labelTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(labelTitle.snp.bottom).offset(16)
            make.height.equalTo(280)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func bind() { }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension EventCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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

extension EventCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: collectionView.frame.height)
    }
}
