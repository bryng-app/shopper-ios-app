//
//  SwipingController.swift
//  bryng
//
//  Created by Florian Woelki on 16.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class PreviewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var pages = [Page]()
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
        btn.tintColor = UIColor.primaryColor
        btn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        return btn
    }()
    
    @objc private func didTapNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        changeCurrentPage(index: nextIndex)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor.primaryColor
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
            previousButton.tintColor = UIColor.primaryColor
        }
        
        if index == pages.count - 1 {
            nextButton.tintColor = .gray
        } else {
            nextButton.tintColor = UIColor.primaryColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pages = [
            Page(headline: "Kaufe Deine Lebensmittel bei uns in der App", text: "Heutzutage sollte es nicht mehr schwierig sein Lebensmittel online zukaufen. Bei uns kannst du ganz einfach Deine gewünschten Lebensmittel, wie aus einem Regal, nehmen und kaufen!", image: #imageLiteral(resourceName: "preview_page_1")),
            Page(headline: "Lasse Deine Lebensmittel bryngen", text: "Es klingt einfach ist aber genial! Lasse Deine Lebensmittel zu Deinem gewünschten Standort bringen. Es ist egal, ob Du auf Arbeit oder Zuhause bist!", image: #imageLiteral(resourceName: "preview_page_2")),
            Page(headline: "Lerne neue Leute kennen", text: "Wir haben keine Mitarbeiter. Dementsprechend kannst Du jeden Tag neue Leute kennenlernen, denn sie bringen Dir Deine Lebensmittel!", image: #imageLiteral(resourceName: "preview_page_3")),
        ]
        
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
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PreviewPageCell
        
        cell.page = pages[indexPath.row]
        cell.handleTipOnGetStarted = { [weak self] in
            CoreDataManager.shared.setFirstLogin()
            self?.navigationController?.pushViewController(BaseTabBarController(), animated: true)
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
