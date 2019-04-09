//
//  HorizontalSnappingController.swift
//  bryng
//
//  Created by Florian Woelki on 09.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    
    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
