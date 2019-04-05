//
//  StoreItemsFullscreenController.swift
//  bryng
//
//  Created by Florian Woelki on 05.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreItemsFullscreenController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .green
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
