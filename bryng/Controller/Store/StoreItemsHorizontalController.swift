//
//  StoreItemsHorizontalController.swift
//  bryng
//
//  Created by Florian Woelki on 09.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreItemsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {

    fileprivate var storeItems: [StoreItem]!
    
    fileprivate let cellId = "cellId"
    fileprivate let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    var category: String? {
        didSet {
            guard let category = category else { return }
            
            fetchStoreItems(category)
        }
    }
    
    private func fetchStoreItems(_ category: String) {
        let getProductsQuery = GetProductsQuery(name: category)
        
        GraphQL.shared.apollo.fetch(query: getProductsQuery) { [weak self] result, error in
            if let error = error {
                print("Something went wrong while fetching 'getProducts' query! \(error)")
                return
            }
            
            guard let products = result?.data?.getProducts else { return }
            
            self?.storeItems.removeAll()
            products.forEach({
                let image = $0.image == "" ? nil : $0.image
                let storeItem = StoreItem(name: $0.name, image: image, price: $0.price, weight: $0.weight, storeName: $0.storeName, categoryName: $0.categoryName)
                self?.storeItems.append(storeItem)
            })
            self?.collectionView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeItems = [StoreItem]()
        
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(StoreItemRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StoreItemRowCell
        cell.storeItem = storeItems[indexPath.row]
        cell.didAddItemToCart = {
            let name = Notification.Name(rawValue: addItemToCartNotificationKey)
            NotificationCenter.default.post(name: name, object: nil)
        }
        return cell
    }
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
        return .init(width: view.frame.width - 48, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
    }
    
}
