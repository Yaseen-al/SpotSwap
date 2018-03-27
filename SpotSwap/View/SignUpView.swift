//
//  SignUpView.swift
//  SpotSwap
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit
import SnapKit
protocol SignUpViewDelegate: class {
    func dismissKeyBoard()
    func profileImageTapGesture()
}
class SignUpView: UIView, UIGestureRecognizerDelegate {
    // MARK: - Properties
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "defaultProfileImage")
        imageView.backgroundColor = Stylesheet.Colors.White
        imageView.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        tapGesture.delegate = self
        imageView.isUserInteractionEnabled = true //essential for the tapGesture to work
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
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
    lazy var userNameLogo: UIImageView = {
        let iView = UIImageView()
        iView.image = #imageLiteral(resourceName: "user-name white")
        iView.contentMode = .scaleToFill
//        iView.backgroundColor = .white
        return iView
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
    lazy var emailLogo: UIImageView = {
        let iView = UIImageView()
        iView.image = #imageLiteral(resourceName: "envelope white")
        iView.contentMode = .scaleToFill
//        iView.backgroundColor = .white
        return iView
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true // this helps to obscure the user's password with *******
        return textField
    }()
    lazy var passwordLogo: UIImageView = {
        let iView = UIImageView()
        iView.image = #imageLiteral(resourceName: "password white")
        iView.contentMode = .scaleToFill
//        iView.backgroundColor = .white
        return iView
    }()
    // MARK: - Delegates
    weak var signUpViewDelegate: SignUpViewDelegate?
    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = Stylesheet.Colors.OrangeMain
        setupViews()
    }
    
    // MARK: - LayoutSubViews

    override func layoutSubviews() {
        // here you get the actual frame size of the elements before getting laid out on screen
        super.layoutSubviews()
        setupProfileImageLayout()
        //Email Logo
        emailLogo.layer.cornerRadius = 5
        emailLogo.layer.masksToBounds = true
        //Password Logo
        passwordLogo.layer.cornerRadius = 5
        passwordLogo.layer.masksToBounds = true
        //UserName Logo
        userNameLogo.layer.cornerRadius = 5
        userNameLogo.layer.masksToBounds = true
    }
    private func setupProfileImageLayout() {
        profileImage.layer.cornerRadius = profileImage.bounds.width/2.0
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderColor = Stylesheet.Colors.PinkMain.cgColor
        profileImage.layer.borderWidth = 4
    }
    // MARK: - Setup Views

    private func setupViews() {
        setupAppLabel()
        setupSloganLabel()
        setupProfileImage()
        setupUsernameTF()
        setupUserNameLogo()
        setupEmailTF()
        setupEmailLogo()
        setupPasswordTF()
        setupPasswordLogo()
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
    private func setupProfileImage(){
        addSubview(profileImage)
        profileImage.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(appSloganLabel.snp.top).offset(50)
            constraint.centerX.equalTo(snp.centerX)
            constraint.width.equalTo(snp.width).multipliedBy(0.40)
            constraint.height.equalTo(profileImage.snp.width)
        }
    }
    
    private func setupUsernameTF() {
        addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(profileImage.snp.bottom).offset(40)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
        }
    }
    private func setupUserNameLogo(){
        addSubview(userNameLogo)
        userNameLogo.snp.makeConstraints { (make) in
            make.centerY.equalTo(usernameTextField.snp.centerY)
            make.right.equalTo(usernameTextField.snp.left).offset(-5)
            make.width.height.equalTo(snp.width).multipliedBy(0.08)
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
    private func setupEmailLogo(){
        addSubview(emailLogo)
        emailLogo.snp.makeConstraints { (make) in
            make.centerY.equalTo(emailTextField.snp.centerY)
            make.right.equalTo(emailTextField.snp.left).offset(-5)
            make.width.height.equalTo(snp.width).multipliedBy(0.08)
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
    private func setupPasswordLogo(){
        addSubview(passwordLogo)
        passwordLogo.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.right.equalTo(passwordTextField.snp.left).offset(-5)
            make.width.height.equalTo(snp.width).multipliedBy(0.08)
        }
    }
    
    //MARK: Actions
    @objc private func dismissKeyboard() {
       signUpViewDelegate?.dismissKeyBoard()
    }
    @objc private func changeProfileImage() {
        signUpViewDelegate?.profileImageTapGesture()
    }

    
}
