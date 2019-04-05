//
//  StoreItemsHeader.swift
//  bryng
//
//  Created by Florian Woelki on 05.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreItemsHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
