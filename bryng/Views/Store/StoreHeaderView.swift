//
//  StoreHeaderView.swift
//  bryng
//
//  Created by Florian Woelki on 06.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreHeaderView: UICollectionReusableView {
    
    var handleDismiss: (() -> ())?
    var didClickCartButton: (() -> ())?
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "store_header"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    let cartButton: BadgeButton = {
        let btn = BadgeButton()
        btn.setImage(#imageLiteral(resourceName: "shopping-cart").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    let informationLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.fillSuperview()

        setupVisualEffectBlur()
        setupGradientLayer()

        addSubview(backButton)
        backButton.anchor(top: nil, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 16, right: 0))
        backButton.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        informationLabel.textColor = .white
        informationLabel.textAlignment = .center
        informationLabel.numberOfLines = 0
        
        let attributedText = NSMutableAttributedString(string: "Netto", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "\nAlle Produkte", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        informationLabel.attributedText = attributedText
        
        addSubview(cartButton)
        cartButton.anchor(top: nil, leading: nil, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 28))
        cartButton.badgeEdgeInsets = UIEdgeInsets(top: 16, left: 28, bottom: 0, right: 0)
        cartButton.badge = "0"
        cartButton.addTarget(self, action: #selector(handleCartButton), for: .touchUpInside)
    }
    
    @objc fileprivate func handleCloseButton() {
        handleDismiss?()
    }
    
    @objc fileprivate func handleCartButton() {
        didClickCartButton?()
    }
    
    func addItemToCart() {
        // .badge not working.. causing layout bug
        var cartItemsCount = Int(cartButton.badgeLabel.text ?? "0") ?? 0
        cartItemsCount += 1
        cartButton.badgeLabel.text = "\(String(cartItemsCount))"
    }

    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]

        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)

        gradientLayer.frame = bounds

        gradientLayer.frame.origin.y -= bounds.height
    }
    
    var animator: UIViewPropertyAnimator!
    
    fileprivate func setupVisualEffectBlur() {
        let visualEffectView = UIVisualEffectView(effect: nil)
        
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: {
            visualEffectView.effect = UIBlurEffect(style: .regular)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
