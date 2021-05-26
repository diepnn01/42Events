//
//  MainHeaderView.swift
//  42Events
//
//  Created by Diep Nguyen on 25/05/2021.
//

import UIKit
import RxSwift
import SnapKit

class MainHeaderView: UIView, BaseViewType {
    
    var disposeBag = DisposeBag()
    var currentPage: Int = 0
    var timer: Timer?
    var banners = ["https://images.weserv.nl/?url=https://virtual-race-submissions.s3-ap-southeast-1.amazonaws.com/images/Web-Banner-B-jpg-6cd04092020-72239&w=560&h=560&fit=outside", "https://images.weserv.nl/?url=https://virtual-race-submissions.s3-ap-southeast-1.amazonaws.com/images/-test-50day-running-challenge-thai-banner-top-of-webpage-jpg-21u09122020-33924&w=560&h=560&fit=outside", "https://images.weserv.nl/?url=https://virtual-race-submissions.s3-ap-southeast-1.amazonaws.com/images/Web-Banner-B-3-jpg-k4b02102020-80717&w=560&h=560&fit=outside", "https://images.weserv.nl/?url=https://virtual-race-submissions.s3-ap-southeast-1.amazonaws.com/images/Web-Banner-B-3-jpg-k4b02102020-80717&w=560&h=560&fit=outside"]
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenWidth, height: screenWidth*9/16)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(HeaderCarouselCell.self,
                                forCellWithReuseIdentifier: HeaderCarouselCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    lazy private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = .blue
        pageControl.currentPage = 2
        pageControl.numberOfPages = banners.count
        return pageControl
    }()
    
    func layout() {
        [collectionView, pageControl].forEach(addSubview)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        timer = .scheduledTimer(timeInterval: 3, target: self,
                                selector: #selector(scrollToNextPage),
                                userInfo: nil,
                                repeats: true)
    }
    
    func bind() { }
    
    @objc private func scrollToNextPage() {
        currentPage += 1
        if currentPage >= banners.count {
            currentPage = 0
        }
        pageControl.currentPage = currentPage
        collectionView.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension MainHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCarouselCell.className,
                                                            for: indexPath) as? HeaderCarouselCell else {
            return UICollectionViewCell()
        }
        cell.imageUrl = banners[indexPath.row]
        return cell
    }
}

extension MainHeaderView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
}

