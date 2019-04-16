//
//  MapStoreInformationView.swift
//  bryng
//
//  Created by Florian Woelki on 15.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class MapStoreInformationView: UIView {
    
    var didClickOnGoTo: (() -> ())?
    
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
    
    lazy var goToButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Einkaufen", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.primaryColor
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.widthAnchor.constraint(equalToConstant: 95).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(didTapOnGoTo), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(red:230/255, green:230/255, blue:230/255, alpha: 1).cgColor
        
        setupLayout()
    }
    
    private func setupLayout() {
        let labelStackView = VerticalStackView(arrangedSubviews: [
            nameLabel,
            distanceLabel,
            openingHoursLabel
            ], spacing: 0)
        
        let overallStackView = UIStackView(arrangedSubviews: [
            imageView,
            labelStackView,
            goToButton
            ])
        overallStackView.alignment = .center
        overallStackView.spacing = 12
        
        addSubview(overallStackView)
        overallStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 50, left: 24, bottom: 0, right: 24))
    }
    
    @objc private func didTapOnGoTo() {
        didClickOnGoTo?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
