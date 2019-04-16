//
//  SwipingController.swift
//  bryng
//
//  Created by Florian Woelki on 16.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class PreviewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    private let previousButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "arrow_left").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .gray
        btn.addTarget(self, action: #selector(didTapPrevious), for: .touchUpInside)
        return btn
    }()
    
    @objc private func didTapPrevious() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = nextIndex
        changeCurrentPage(index: nextIndex)
    }
    
    private let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "arrow_right").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = #colorLiteral(red: 1, green: 0.356151558, blue: 0.3902737024, alpha: 1)
        btn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        return btn
    }()
    
    @objc private func didTapNext() {
        let nextIndex = min(pageControl.currentPage + 1, 4 - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        changeCurrentPage(index: nextIndex)
    }
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.356151558, blue: 0.3902737024, alpha: 1)
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        changeCurrentPage(index: Int(x / view.frame.width))
    }
    
    private func changeCurrentPage(index: Int) {
        pageControl.currentPage = index
        
        if index == 0 {
            previousButton.tintColor = .gray
        } else {
            previousButton.tintColor = #colorLiteral(red: 1, green: 0.356151558, blue: 0.3902737024, alpha: 1)
        }
        
        if index == 3 {
            nextButton.tintColor = .gray
        } else {
            nextButton.tintColor = #colorLiteral(red: 1, green: 0.356151558, blue: 0.3902737024, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(PreviewPageCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.isPagingEnabled = true
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [
            previousButton, pageControl, nextButton
            ])
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        bottomControlsStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 24, right: 8))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PreviewPageCell
        
        cell.handleTipOnGetStarted = { [weak self] in
            self?.present(RegistrationController(), animated: true, completion: nil)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}