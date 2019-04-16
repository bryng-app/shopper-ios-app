//
//  PreviewPageCell.swift
//  bryng
//
//  Created by Florian Woelki on 16.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class PreviewPageCell: UICollectionViewCell {
    
    var handleTipOnGetStarted: (() -> ())?
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)])
        
        attributedText.append(NSMutableAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    private lazy var getStartedButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Jetzt einkaufen!", for: .normal)
        btn.setTitleColor(UIColor.primaryColor, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.primaryColor.cgColor
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(didTapOnGetStarted), for: .touchUpInside)
        return btn
    }()
    
    @objc private func didTapOnGetStarted() {
        handleTipOnGetStarted?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(descriptionTextView)
        descriptionTextView.constrainWidth(constant: frame.width - 24)
        descriptionTextView.centerInSuperview()
        
        addSubview(getStartedButton)
        getStartedButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 114, right: 0))
        getStartedButton.centerXInSuperview()
        getStartedButton.constrainHeight(constant: 48)
        getStartedButton.constrainWidth(constant: 150)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
