import UIKit
import SnapKit

class LoginView: UIView {
    
    // MARK: - Properties
    lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "43iosgroup6logo")
        logo.contentMode = .scaleAspectFit
        //style details
        logo.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        logo.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        logo.layer.shadowOpacity = 1.0
        logo.layer.shadowRadius = 0.0
        logo.clipsToBounds = false
        logo.layer.masksToBounds = false
        return logo
    }()
    
    lazy var logoSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Share your parking spot with people nearby"
        return label
    }()
  
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Enter your Email"
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
        return iView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = Stylesheet.Colors.BlueMain
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        prepareViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup Views
    private func prepareViews() {
        setupLogoImage()
        setupEmailTextField()
        setupEmailLogo()
        setupPasswordTextField()
        setupPasswordLogo()
        setupLoginButton()
        setupLogoSubtitleLabel()
        setupButtonDetails()

    }
    override func layoutSubviews() {
        //Email Logo
        emailLogo.layer.cornerRadius = 5
        emailLogo.layer.masksToBounds = true
        //Password Logo
        passwordLogo.layer.cornerRadius = 5
        passwordLogo.layer.masksToBounds = true
    }
    //For login button - rounds the corners and gives it a shadow
    func setupButtonDetails() {
        //button.titleLabel?.font = button.titleLabel?.font.withSize(12)
        loginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        loginButton.layer.shadowOpacity = 1.0
        loginButton.layer.shadowRadius = 0.0
        loginButton.clipsToBounds = false
        loginButton.layer.masksToBounds = false
        loginButton.layer.cornerRadius = 5 //loginButton.frame.height / 2
    }
    
    private func setupLogoImage() {
        self.addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.80)
            make.height.equalTo(snp.height).multipliedBy(0.40)
        }
    }
    
    private func setupLogoSubtitleLabel() {
        addSubview(logoSubtitleLabel)
        logoSubtitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(emailTextField).offset(-100)
        }
    }
    
    private func setupEmailTextField() {
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
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
    
    private func setupPasswordTextField() {
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(emailTextField).offset(70)
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
    
    private func setupLoginButton() {
        self.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(snp.bottom).offset(-50)
            make.height.equalTo(22)
            make.width.equalTo(60)
        }
    }


}



