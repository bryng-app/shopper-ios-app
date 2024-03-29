//
//  CloseHeaderView.swift
//  bryng
//
//  Created by Florian Woelki on 13.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class CloseHeaderView: UICollectionReusableView {
    
    var handleDismiss: (() -> ())?
    
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    let titleLabel = UILabel(text: "Placeholder", font: .boldSystemFont(ofSize: 30))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 24))
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

