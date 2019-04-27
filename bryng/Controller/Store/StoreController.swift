//
//  StoreController.swift
//  bryng
//
//  Created by Florian Woelki on 06.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

let addItemToCartNotificationKey = "app.bryng.addItemToCart"

class StoreController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var storeCategories = [StoreCategory]()
    
    var storeName = "Store Name"
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate let padding: CGFloat = 16
    
    fileprivate let addItemToCart = Notification.Name(rawValue: addItemToCartNotificationKey)
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchStoreSections()
        setupCollectionView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(StoreController.addItemToCart(notification:)), name: addItemToCart, object: nil)
    }
    
    private func fetchStoreSections() {
        let allCategoriesQuery = AllCategoriesQuery()
        
        GraphQL.shared.apollo.fetch(query: allCategoriesQuery) { [weak self] result, error in
            if let error = error {
                print("Something went wrong fetch 'allCategories' query! \(error)")
                return
            }
            
            guard let allCategories = result?.data?.allCategories else { return }
            
            allCategories.forEach({self?.storeCategories.append(StoreCategory(name: $0.name))})
            self?.collectionView.reloadData()
        }
    }
    
    @objc func addItemToCart(notification: NSNotification) {
        storeHeaderView?.addItemToCart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(StoreItemsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(StoreHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 0 {
            storeHeaderView?.animator.fractionComplete = 0
            return
        }
        
        storeHeaderView?.animator.fractionComplete = abs(contentOffsetY) / 100
    }
    
    var storeHeaderView: StoreHeaderView?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        storeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? StoreHeaderView
        
        let attributedText = NSMutableAttributedString(string: storeName, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "\nAlle Produkte", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        storeHeaderView?.informationLabel.attributedText = attributedText
        
        storeHeaderView?.handleDismiss = { [weak self] in
            self?.storeHeaderView?.animator.stopAnimation(true)
            // self?.navigationController?.setNavigationBarHidden(false, animated: false)
            self?.navigationController?.popViewController(animated: true)
        }
        
        storeHeaderView?.didClickCartButton = { [weak self] in
            self?.storeHeaderView?.animator.stopAnimation(true)
            
            let transition: CATransition = CATransition()
            transition.duration = 0.35
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromTop
            self?.navigationController!.view.layer.add(transition, forKey: kCATransition)
            self?.navigationController?.pushViewController(CartController(), animated: false)
        }
        
        return storeHeaderView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .init(width: view.frame.width, height: 340)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StoreItemsGroupCell
        cell.storeCategory = storeCategories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 16, left: 0, bottom: 80, right: 0)
    }
    
    init() {
        super.init(collectionViewLayout: StoreHeaderLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
