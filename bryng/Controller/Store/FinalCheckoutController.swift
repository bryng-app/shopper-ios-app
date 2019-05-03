//
//  FinalCheckoutController.swift
//  bryng
//
//  Created by Florian Woelki on 02.05.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class FinalCheckoutController: UIViewController {
    
    var time: String?
    
    private let totalPriceLabel = UILabel(text: "Dein Gesamtpreis", font: .systemFont(ofSize: 20))
    
    private let productListPriceLabel = UILabel(text: "- Kosten für Produkte", font: .systemFont(ofSize: 18))
    private let productListRealPriceLabel = UILabel(text: "39,99€", font: .systemFont(ofSize: 18, weight: .medium))
    
    private let timePriceLabel = UILabel(text: "- Kosten für Zeit", font: .systemFont(ofSize: 18))
    private let timeRealPriceLabel = UILabel(text: "9,99€", font: .systemFont(ofSize: 18, weight: .medium))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(totalPriceLabel)
        totalPriceLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 32, bottom: 0, right: 0))
        
        let timePriceStackView = UIStackView(arrangedSubviews: [
            timePriceLabel, timeRealPriceLabel
            ])
        timePriceStackView.distribution = .fillEqually
        
        let productListPriceStackView = UIStackView(arrangedSubviews: [
            productListPriceLabel, productListRealPriceLabel
            ])
        productListPriceStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [
            timePriceStackView, productListPriceStackView
            ], spacing: 8)
        
        view.addSubview(overallStackView)
        overallStackView.anchor(top: totalPriceLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 32, bottom: 0, right: 0))
        
        let seperator = UISeperator.create()
        view.addSubview(seperator)
        seperator.anchor(top: overallStackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 32, bottom: 0, right: 0))
    }
    
    private func calculateTimePrice(_ time: String) -> Double {
        return 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Gesamtpreis"
    }
    
}
