//
//  CartFooter.swift
//  bryng
//
//  Created by Florian Woelki on 29.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class CartFooter: UIView {
    
    var total: Double? {
        didSet {
            guard let total = total else { return }
            
            let roundedTotal = Double(round(100 * total) / 100)
            var transformedPrice = String(roundedTotal).replacingOccurrences(of: ".", with: ",")
            if transformedPrice.count <= 3 {
                transformedPrice.append("0")
            }
            
            if total == 0.0 {
                checkoutButton.isEnabled = false
                checkoutButton.backgroundColor = .gray
                checkoutButton.setTitleColor(.white, for: .normal)
            }
            
            totalCartItemsCost.text = "Kosten: \(transformedPrice.prefix(4))€"
        }
    }
    
    var didClickOnCheckout: (() ->())?
    
    private let totalCartItemsCost: UILabel = {
        let label = UILabel(text: "Kosten: 00,00€")
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var checkoutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Kaufen", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.primaryColor
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(didTapCheckout), for: .touchUpInside)
        return btn
    }()
    
    @objc private func didTapCheckout() {
        didClickOnCheckout?()
    }
    
    private let seperator = UISeperator.create()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(checkoutButton)
        checkoutButton.constrainWidth(constant: 128)
        checkoutButton.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 28, left: 0, bottom: 28, right: 16))
        
        let stackView = VerticalStackView(arrangedSubviews: [seperator, totalCartItemsCost], spacing: 8)
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 28, left: 16, bottom: 28, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
