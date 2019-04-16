//
//  OrdersController.swift
//  bryng
//
//  Created by Florian Woelki on 13.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class OrdersController: ProfileBaseViewController {
    
    private let cellId = "cellId"
    
    private let orders = [String]() // TODO: Change to real order model
    
    private let noOrdersLabel = UILabel(text: "Du hast noch keine Bestellungen!", font: .systemFont(ofSize: 24), numberOfLines: 2)
    private let noOrdersEmojiLabel = UILabel(text: "🛍", font: .systemFont(ofSize: 32), numberOfLines: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerBackgroundColor = .modernGray
        headerTitle = "Bestellungen"
        collectionView.backgroundColor = .modernGray
        
        collectionView.register(OrderCell.self, forCellWithReuseIdentifier: cellId)
        
        if orders.count == 0 {
            noOrdersLabel.textAlignment = .center
            noOrdersEmojiLabel.textAlignment = .center
            
            let stackView = VerticalStackView(arrangedSubviews: [
                noOrdersLabel,
                noOrdersEmojiLabel
                ], spacing: 16)
            collectionView.addSubview(stackView)
            stackView.fillSuperview(padding: .init(top: 160, left: 0, bottom: 0, right: 0))
            stackView.centerXInSuperview()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OrderCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 24, left: 0, bottom: 24, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 125)
    }
    
}
