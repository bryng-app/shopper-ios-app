//
//  CartHeaderView.swift
//  bryng
//
//  Created by Florian Woelki on 11.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class CartHeaderView: UICollectionReusableView {
    
    var handleDismiss: (() -> ())?
    
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .black
        return btn
    }()

    let titleLabel = UILabel(text: "Dein Warenkorb", font: .boldSystemFont(ofSize: 30))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        backgroundColor = #colorLiteral(red: 0.9415884067, green: 0.9415884067, blue: 0.9415884067, alpha: 1)

        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 24))
        closeButton.addTarget(self, action: #selector(handleClickOnClose), for: .touchUpInside)

        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 5, left: 24, bottom: 5, right: 0))
    }
    
    @objc fileprivate func handleClickOnClose() {
        handleDismiss?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
