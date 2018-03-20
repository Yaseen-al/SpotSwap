//
//  RegisterCarView.swift
//  SpotSwap
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit
import SnapKit

class RegisterCarView: UIView {
    
    lazy var cameraButton: UIButton = {
        var button = UIButton()
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    lazy var makeLabel: UILabel = {
        let label = UILabel()
        label.text = "Make"
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    lazy var carMakeTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Enter car make"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var modelLabel: UILabel = {
        let label = UILabel()
        label.text = "Model"
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    lazy var carModelTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Enter car model"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = Stylesheet.Colors.PinkMain
        setupViews()
    }
    
    
    override func layoutSubviews() {
        // here you get the actual frame size of the elements before getting
        // laid out on screen
        super.layoutSubviews()
        carImageView.layer.cornerRadius = carImageView.bounds.width/2.0
        carImageView.layer.masksToBounds = true
        carImageView.layer.borderColor = UIColor.white.cgColor
        carImageView.layer.borderWidth = 4
    }
    
    private func setupViews() {
        setupCarImage()
        setupCameraButton()
        setupMakeLabel()
        setupMakeTF()
        setupModelLabel()
        setupModelTF()
    }
    
    private func setupCarImage() {
        addSubview(carImageView)
        carImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.40)
            make.height.equalTo(carImageView.snp.width)
        }
    }
    
    private func setupCameraButton() {
        addSubview(cameraButton)
        cameraButton.snp.makeConstraints { (make) in
            make.top.equalTo(carImageView.snp.top)
            make.centerX.equalTo(carImageView.snp.centerX)
            make.width.equalTo(carImageView.snp.width)
            make.height.equalTo(carImageView.snp.width)
        }
        
    }
    
    private func setupMakeLabel() {
        addSubview(makeLabel)
        makeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(carImageView.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(40)
        }
    }
    
    private func setupMakeTF() {
        addSubview(carMakeTextField)
        carMakeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(makeLabel.snp.bottom).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
        }
    }
    
    private func setupModelLabel() {
        addSubview(modelLabel)
        modelLabel.snp.makeConstraints { (make) in
            make.top.equalTo(carMakeTextField.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(40)
        }
    }
    
    private func setupModelTF() {
        addSubview(carModelTextField)
        carModelTextField.snp.makeConstraints { (make) in
            make.top.equalTo(modelLabel.snp.bottom).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
        }
    }
    
}
