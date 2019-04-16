//
// Created by Florian Woelki on 2019-04-12.
// Copyright (c) 2019 bryng. All rights reserved.
//

import UIKit

class CartCell: UICollectionViewCell {
    
    var handleDelete: (() -> ())?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return iv
    }()
    
    let productNameLabel = UILabel(text: "Apfel")
    let priceLabel = UILabel(text: "0,15€ je", font: .systemFont(ofSize: 14))
    let amountLabel = UILabel(text: "Anzahl: 3", font: .systemFont(ofSize: 14))
    
    lazy var deleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Löschen", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.primaryColor
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.widthAnchor.constraint(equalToConstant: 95).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(didTapOnDelete), for: .touchUpInside)
        return btn
    }()
    
    @objc private func didTapOnDelete() {
        handleDelete?()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        layer.cornerRadius = 16
        
        setupLayout()
    }
    
    private func setupLayout() {
        let labelStackView = VerticalStackView(arrangedSubviews: [
            productNameLabel, priceLabel, amountLabel
            ], spacing: 0)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, labelStackView, deleteButton
            ])
        stackView.spacing = 12
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 24, bottom: 16, right: 24))
    }

    required init(coder: NSCoder) {
        fatalError()
    }

}
