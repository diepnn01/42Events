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
    private var currentPage: Int = 0
    private var timer: Timer?
    private var banners = [String]()
    
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
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.red
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
    
    private func resetTimer() {
        guard banners.count > 1 else { return }
        timer = .scheduledTimer(timeInterval: 3, target: self,
                                selector: #selector(scrollToNextPage),
                                userInfo: nil,
                                repeats: true)
    }
    
    func reloadData(_ featuredRaces: [Race]) {
        timer?.invalidate()
        banners = featuredRaces.map({ $0.bannerCard }).compactMap({ $0 })
        pageControl.numberOfPages = banners.count
        pageControl.isHidden = banners.count <= 1
        currentPage = 0
        collectionView.reloadData()
        resetTimer()
    }
}

extension MainHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(of: HeaderCarouselCell.self, at: indexPath)
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

