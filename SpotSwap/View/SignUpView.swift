//
//  SignUpView.swift
//  SpotSwap
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    
    lazy var backButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        return button
    }()
    
    lazy var nextButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        return button
    }()
    
    lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "SpotSwap"
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    lazy var appSloganLabel: UILabel = {
        let label = UILabel()
        label.text = "Share your parking with people nearby"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Username"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true // this helps to obscure the user's password with *******
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
    
    
    //        override func layoutSubviews() {
    //            // here you get the actual frame size of the elements before getting
    //            // laid out on screen
    //            super.layoutSubviews()
    //        }
    
    private func setupViews() {
        //            setupButtons()
        setupAppLabel()
        setupSloganLabel()
        setupUsernameTF()
        setupEmailTF()
        setupPasswordTF()
    }
    
    
    private func setupButtons(){
        //        addSubview(backButton)
        //        backButton.snp.makeConstraints { (make) in
        //        }
        //
        //        addSubview(nextButton)
    }
    
    private func setupAppLabel() {
        addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.06)
        }
    }
    
    private func setupSloganLabel() {
        addSubview(appSloganLabel)
        appSloganLabel.snp.makeConstraints { (make) in
            make.top.equalTo(appNameLabel.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.06)
        }
    }
    
    private func setupUsernameTF() {
        addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(appSloganLabel.snp.bottom).offset(40)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
        }
    }
    
    private func setupEmailTF() {
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(30)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
        }
    }
    private func setupPasswordTF() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
        }
    }
    
}
