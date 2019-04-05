//
//  GroceryShopCell.swift
//  bryng
//
//  Created by Florian Woelki on 03.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return iv
    }()
    
    let nameLabel = UILabel(text: "Store Name")
    let distanceLabel = UILabel(text: "7.4km entfernt", font: .systemFont(ofSize: 14))
    let openingHoursLabel = UILabel(text: "08-20 Uhr", font: .systemFont(ofSize: 14))
    
    let goToButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Einkaufen", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
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
            nameLabel, distanceLabel, openingHoursLabel
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
        didSelectHandler?("bryng von STORE NAME")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
