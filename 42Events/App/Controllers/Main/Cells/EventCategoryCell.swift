//
//  EventCategoryCell.swift
//  42Events
//
//  Created by Diep Nguyen on 26/05/2021.
//

import UIKit
import RxSwift
import SnapKit

enum EventCategoryType: Int, CaseIterable {
    case running
    case cycling
    case walking
    
    var title: String {
        switch self {
        case .running:
            return "Running"
        case .cycling:
            return "Cycling"
        case .walking:
            return "Walking"
        }
    }
    
    var bgColor: UIColor {
        switch self {
        case .running:
            return UIColor(red: 8/255, green: 191/255, blue: 169/255, alpha: 1)
        case .cycling:
            return UIColor(red: 58/255, green: 183/255, blue: 240/255, alpha: 1)
        case .walking:
            return UIColor(red: 255/255, green: 112/255, blue: 67/255, alpha: 1)
        }
    }
    
    var linkBg: String {
        switch self {
        case .running:
            return "https://virtual-race-submissions.s3-ap-southeast-1.amazonaws.com/images/category-run-png-nwn10102019-104426"
        case .cycling:
            return "https://virtual-race-submissions.s3-ap-southeast-1.amazonaws.com/images/category-bike-png-udy10102019-110227"
        case .walking:
            return "https://virtual-race-submissions.s3-ap-southeast-1.amazonaws.com/images/category-walk-png-67w10102019-110311"
        }
    }
}

class EventCategoryCell: UITableViewCell, BaseViewType {

    var disposeBag = DisposeBag()
    var onSelectedIndex: ((Int) -> Void)?
    lazy private var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "EventCategoryCell.Event".localized
        label.font = UIFont.metropolisBold(ofSize: 20)
        return label
    }()
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(EventCategoryCollectionCell.self,
                                forCellWithReuseIdentifier: EventCategoryCollectionCell.className)
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
    
    func layout() {
        selectionStyle = .none
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.colorFromHex("#E6E6E6")
        [labelTitle, collectionView, separatorLine].forEach(contentView.addSubview)
        labelTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        let width = (UIScreen.main.bounds.width - 12)/3
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
            make.top.equalTo(labelTitle.snp.bottom).offset(2)
            make.height.equalTo(width*3/4)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(0)
            make.height.equalTo(1)
        }
    }
    
    func bind() { }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension EventCategoryCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventCategoryType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCategoryCollectionCell.className,
                                                            for: indexPath) as? EventCategoryCollectionCell else {
            return UICollectionViewCell()
        }
        cell.type = EventCategoryType.allCases[indexPath.row]
        return cell
    }
}

extension EventCategoryCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelectedIndex?(indexPath.row)
    }
}

extension EventCategoryCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        let itemSize = CGSize(width: (screenWidth-6)/3, height: collectionView.frame.height)
        return itemSize
    }
}
