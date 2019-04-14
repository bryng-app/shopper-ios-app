//
//  SocialMediaCell.swift
//  bryng
//
//  Created by Florian Woelki on 13.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class SocialMediaCell: UICollectionViewCell {
    
    var link: String!
    
    let nameLabel = UILabel(text: "Social Media Name")
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return iv
    }()
    
    let followButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Folgen", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.356151558, blue: 0.3902737024, alpha: 1)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.widthAnchor.constraint(equalToConstant: 95).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        setupLayout()
    }
    
    private func setupLayout() {
        followButton.addTarget(self, action: #selector(didTapOnFollow), for: .touchUpInside)
    
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            nameLabel,
            followButton
            ])
        stackView.alignment = .center
        stackView.spacing = 12
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 24, bottom: 16, right: 24))
    }
    
    @objc private func didTapOnFollow() {
        if let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
