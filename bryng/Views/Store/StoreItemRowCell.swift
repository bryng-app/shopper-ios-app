//
//  StoreItemRowCell.swift
//  bryng
//
//  Created by Florian Woelki on 09.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreItemRowCell: UICollectionViewCell {

    var didAddItemToCart: (() -> ())?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .yellow
        iv.constrainWidth(constant: 64)
        iv.constrainHeight(constant: 64)
        return iv
    }()
    
    let priceLabel = UILabel(text: "0,15€ je", font: .systemFont(ofSize: 20))
    let nameLabel = UILabel(text: "Apfel", font: .systemFont(ofSize: 15))
    
    let getButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "add"), for: .normal)
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
                priceLabel, nameLabel], spacing: 4),
            getButton
            ])
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    @objc fileprivate func onAddItemToCart() {
        didAddItemToCart?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
