//
//  StoreItemRowCell.swift
//  bryng
//
//  Created by Florian Woelki on 09.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreItemRowCell: UICollectionViewCell {
    
    var storeItem: StoreItem? {
        didSet {
            guard let storeItem = storeItem else { return }
            
            var transformedPrice = String(storeItem.price).replacingOccurrences(of: ".", with: ",")
            if transformedPrice.count <= 3 {
                transformedPrice.append("0")
            }
                
            priceLabel.text = "\(transformedPrice)€ je"
            nameLabel.text = storeItem.name
            weightLabel.text = storeItem.weight
            fetchImage(storeItem.image)
        }
    }
    
    private func fetchImage(_ imageUrl: String) {
        imageView.downloaded(from: imageUrl)
    }

    var didAddItemToCart: (() -> ())?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.image = #imageLiteral(resourceName: "select_photo_empty")
        iv.contentMode = .scaleAspectFit
        iv.constrainWidth(constant: 64)
        iv.constrainHeight(constant: 64)
        iv.layer.cornerRadius = 16
        return iv
    }()
    
    let priceLabel = UILabel(text: "0,15€ je", font: .systemFont(ofSize: 20))
    let weightLabel = UILabel(text: "1 Stück", font: .systemFont(ofSize: 15))
    let nameLabel = UILabel(text: "Apfel", font: .systemFont(ofSize: 15))
    
    let getButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = UIColor.primaryColor
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 32 / 2
        getButton.addTarget(self, action: #selector(onAddItemToCart), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                priceLabel, weightLabel, nameLabel], spacing: 2),
            getButton
            ])
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    @objc fileprivate func onAddItemToCart() {
        getButton.pulsate()
        didAddItemToCart?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
