//
//  PreviewPageCell.swift
//  bryng
//
//  Created by Florian Woelki on 16.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class PreviewPageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let page = page else { return }
            
            let attributedText = NSMutableAttributedString(string: page.headline, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            
            attributedText.append(NSMutableAttributedString(string: "\n\n\n\(page.text)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
            descriptionTextView.isEditable = false
            descriptionTextView.isScrollEnabled = false
            
            guard let pageImage = page.image else { return }
            
            imageView.image = pageImage
            imageView.constrainHeight(constant: 200)
            imageView.constrainWidth(constant: 200)
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    var handleTipOnGetStarted: (() -> ())?
    
    private let imageView = UIImageView()
    private let descriptionTextView = UITextView()
    
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
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 128, left: 64, bottom: 0, right: 64))
        imageView.centerXInSuperview()
        
        addSubview(getStartedButton)
        getStartedButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 114, right: 0))
        getStartedButton.centerXInSuperview()
        getStartedButton.constrainHeight(constant: 48)
        getStartedButton.constrainWidth(constant: 150)
        
        addSubview(descriptionTextView)
        descriptionTextView.constrainWidth(constant: frame.width)
        descriptionTextView.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: getStartedButton.topAnchor, trailing: trailingAnchor, padding: .init(top: 32, left: 40, bottom: 0, right: 40))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
