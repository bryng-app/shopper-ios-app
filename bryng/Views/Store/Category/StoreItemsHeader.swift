//
//  StoreItemsHeader.swift
//  bryng
//
//  Created by Florian Woelki on 05.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreItemsHeader: UICollectionReusableView {
    
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .red
        
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16), size: .init(width: 80, height: 38))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
