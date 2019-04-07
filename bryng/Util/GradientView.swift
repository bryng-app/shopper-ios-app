//
//  GradientView.swift
//  bryng
//
//  Created by Florian Woelki on 07.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        guard let theLayer = self.layer as? CAGradientLayer else { return }
        
        theLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        theLayer.locations = [0.5, 1.1]
        theLayer.frame = bounds
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
}
