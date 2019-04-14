//
//  BryngTextField.swift
//  bryng
//
//  Created by Florian Woelki on 14.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class BryngTextField: UITextField {
    
    let height: CGFloat
    let padding: CGFloat
    
    init(padding: CGFloat, height: CGFloat, type: UIKeyboardType = .default) {
        self.padding = padding
        self.height = height
        super.init(frame: .zero)
        layer.cornerRadius = 25
        keyboardType = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: height)
    }
    
}
