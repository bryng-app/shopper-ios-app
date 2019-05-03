//
//  DeliveryTimeController.swift
//  bryng
//
//  Created by Florian Woelki on 01.05.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class DeliveryTimeController: BaseViewController {
    
    private let titleLabel = UILabel(text: "Wähle Deine Lieferzeit", font: .boldSystemFont(ofSize: 24))
    
    private let pricesInformationLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Alle Preisinformationen findest du unter\n", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "https://bryng.app/prices", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "en_FR")
        var currentDate = Date()
        currentDate = currentDate.addingTimeInterval(60.0 * 60.0)
        picker.minimumDate = currentDate
        picker.date = currentDate
        return picker
    }()
    
    private lazy var continueButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Weiter", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.primaryColor
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return btn
    }()
    
    @objc private func handleContinue() {
        let time = getTime()
        let finalCheckoutController = FinalCheckoutController()
        finalCheckoutController.time = time
        
        navigationController?.pushViewController(finalCheckoutController, animated: true)
    }
    
    private func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_FR")
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.string(from: timePicker.date)
        return strDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 32, left: 16, bottom: 0, right: 0))
        
        view.addSubview(timePicker)
        timePicker.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 8, bottom: 0, right: 8))
        timePicker.centerXInSuperview()
        
        view.addSubview(continueButton)
        continueButton.anchor(top: timePicker.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        continueButton.constrainWidth(constant: 128)
        continueButton.centerXInSuperview()
        
        view.addSubview(pricesInformationLabel)
        pricesInformationLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 16, right: 8))
        pricesInformationLabel.centerXInSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Lieferzeit"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
