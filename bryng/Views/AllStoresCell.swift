//
//  AllStoresCell.swift
//  bryng
//
//  Created by Florian Woelki on 03.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class AllStoresCell: UICollectionViewCell {
    
    var store: Store? {
        didSet {
            guard let store = store else { return }
            
            nameLabel.text = store.name
            openingHoursLabel.text = "\(store.openingHours) Uhr"
            imageView.image = UIImage(named: store.logo)
            
            // TODO: Set distance label
        }
    }
    
    fileprivate let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate let nameLabel = UILabel(text: "Store Name")
    // fileprivate let distanceLabel = UILabel(text: "7.4km entfernt", font: .systemFont(ofSize: 14))
    fileprivate let openingHoursLabel = UILabel(text: "08-20 Uhr", font: .systemFont(ofSize: 14))
    
    fileprivate let goToButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Einkaufen", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.primaryColor
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.widthAnchor.constraint(equalToConstant: 95).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    var didSelectHandler: ((String) -> ())? // TODO: Change to parsed object
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        let labelsStackView = VerticalStackView(arrangedSubviews: [
            nameLabel, openingHoursLabel
            ], spacing: 0)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, labelsStackView, goToButton
            ])
        stackView.alignment = .center
        stackView.spacing = 12
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 24, bottom: 16, right: 24))
        
        goToButton.addTarget(self, action: #selector(onGoToButtonClick), for: .touchUpInside)
    }
    
    @objc fileprivate func onGoToButtonClick() {
        // TODO: On handle click, parse data
        guard let storeName = store?.name else { return }
        
        didSelectHandler?(storeName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
