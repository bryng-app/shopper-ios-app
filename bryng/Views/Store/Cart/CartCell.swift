//
// Created by Florian Woelki on 2019-04-12.
// Copyright (c) 2019 bryng. All rights reserved.
//

import UIKit

class CartCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        layer.cornerRadius = 16
    }

    required init(coder: NSCoder) {
        fatalError()
    }

}
