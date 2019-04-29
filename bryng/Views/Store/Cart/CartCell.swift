//
//  NewCartCell.swift
//  bryng
//
//  Created by Florian Woelki on 17.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {
    
    var cartProduct: CartProduct? {
        didSet {
            guard let cartProduct = cartProduct else { return }
            
            productNameLabel.text = cartProduct.name
            amount = cartProduct.amount
            amountLabel.text = "Anzahl: \(cartProduct.amount)"
            
            var transformedPrice = String(cartProduct.price).replacingOccurrences(of: ".", with: ",")
            if transformedPrice.count <= 3 {
                transformedPrice.append("0")
            }
            
            priceLabel.text = "\(transformedPrice)€ je"
            
            guard let imageUrl = cartProduct.image else {
                productImageView.image = #imageLiteral(resourceName: "select_photo_empty")
                return
            }
            productImageView.sd_setImage(with: URL(string: imageUrl))
        }
    }
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "select_photo_empty")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 16
        return iv
    }()
    
    private let productNameLabel = UILabel(text: "Apfel", font: .boldSystemFont(ofSize: 16))
    private let priceLabel = UILabel(text: "0,15€ je", font: .systemFont(ofSize: 14))
    private let amountLabel = UILabel(text: "Anzahl: 0", font: .systemFont(ofSize: 14))
    
    private var amount = 0
    
    private lazy var addAmountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .primaryColor
        btn.addTarget(self, action: #selector(didTapOnAddAmount), for: .touchUpInside)
        return btn
    }()
    
    @objc private func didTapOnAddAmount() {
        guard let cartProduct = cartProduct else { return }
        
        CoreDataManager.shared.addCartItem(id: cartProduct.id)
        
        amount += 1
        amountLabel.text = "Anzahl: \(amount)"
        
        removeAmountButton.tintColor = .primaryColor
    }
    
    private lazy var removeAmountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "remove").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .primaryColor
        btn.addTarget(self, action: #selector(didTapOnRemoveAmount), for: .touchUpInside)
        return btn
    }()
    
    @objc private func didTapOnRemoveAmount() {
        if amount > 1 {
            guard let cartProduct = cartProduct else { return }
            
            CoreDataManager.shared.removeCartItem(id: cartProduct.id)
            
            removeAmountButton.tintColor = .primaryColor
            
            amount -= 1
            if amount == 1 {
                removeAmountButton.tintColor = .gray
            }
            amountLabel.text = "Anzahl: \(amount)"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(productImageView)
        
        productImageView.constrainHeight(constant: 64)
        productImageView.constrainWidth(constant: 64)
        productImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        productImageView.centerYInSuperview()
        
        let labelStackView = VerticalStackView(arrangedSubviews: [
            productNameLabel,
            amountLabel,
            priceLabel
            ], spacing: 0)
        
        addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 16).isActive = true
        labelStackView.centerYInSuperview()
        
        let editAmountStackView = UIStackView(arrangedSubviews: [
            addAmountButton,
            removeAmountButton
            ])
        editAmountStackView.spacing = 8
        editAmountStackView.alignment = .center
        
        addSubview(editAmountStackView)
        editAmountStackView.translatesAutoresizingMaskIntoConstraints = false
        editAmountStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        editAmountStackView.centerYInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
