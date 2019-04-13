//
//  UIButton+Profile.swift
//  bryng
//
//  Created by Florian Woelki on 24.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String, imageName: String = "") {
        self.init(type: .system)
        setTitle(title, for: .normal)
        
        if (UIDevice.current.screenType == .iPhones_5_5s_5c_SE) {
            titleLabel?.font = UIFont.systemFont(ofSize: 14)
        } else {
            titleLabel?.font = UIFont.systemFont(ofSize: 18)
        }
        setTitleColor(.black, for: .normal)
        contentHorizontalAlignment = .left
        backgroundColor = .white
        if imageName != "" {
            setImage(UIImage(named: imageName), for: .normal)
        }
    }

    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0

        layer.add(pulse, forKey: nil)
    }
    
}

class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.tintColor = .gray
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 25), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -23, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
    
}

class ButtonWithLink: UIButton {
    
    var link: String!
    
}
