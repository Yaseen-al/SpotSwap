import UIKit
import SnapKit

class LoginView: UIView {
    
    // MARK: - Properties
    lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "SpotSwapLogo")
        return logo
    }()
    
    lazy var logoSubtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 21))
        label.backgroundColor = .yellow
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Share your parking spot with people nearby"
        return label
    }()
  
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your Email"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 2, height: 2)
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 2, height: 2)
//      textField.keyboardType = .
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .blue
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
        setupPasswordTextField()
        setupLoginButton()
        setupLogoSubtitleLabel()

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
        self.addSubview(logoSubtitleLabel)
        logoSubtitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(emailTextField).offset(-100)
        }
    }
    
    private func setupEmailTextField() {
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(snp.width).multipliedBy(0.80)
        }
    }
    
    private func setupPasswordTextField() {
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.80)
            make.top.equalTo(emailTextField).offset(70)
        }
    }
    
    private func setupLoginButton() {
        self.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(snp.bottom).offset(-50)
            make.height.equalTo(20)
            make.width.equalTo(60)
            
        }
    }


}



