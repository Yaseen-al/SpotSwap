import UIKit
import SnapKit

class LoginView: UIView {
    
    // MARK: - Properties
    lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "43iosgroup6logo")
        logo.contentMode = .scaleAspectFill
        //style details
        logo.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        logo.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        logo.layer.shadowOpacity = 1.0
        logo.layer.shadowRadius = 0.0
        //        logo.backgroundColor = .yellow
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
    
    
    lazy var lowerLoginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = Stylesheet.Colors.GrayMain
        button.setTitle("Login", for: .normal)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.shadowOpacity = 1.0
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Stylesheet.Colors.OrangeMain
        prepareViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup Views
    private func prepareViews() {
        setupLogoImage()
        setupLogoSubtitleLabel()
        setupEmailTextField()
        setupEmailLogo()
        setupPasswordTextField()
        setupPasswordLogo()
        setupLowerLoginButton()
        
    }
    override func layoutSubviews() {
        //Email Logo
        emailLogo.layer.cornerRadius = 5
        emailLogo.layer.masksToBounds = true
        //Password Logo
        passwordLogo.layer.cornerRadius = 5
        passwordLogo.layer.masksToBounds = true
        setupLowerButtonDetails()
    }
    //For login button - rounds the corners and gives it a shadow
    func setupLowerButtonDetails() {
        //button.titleLabel?.font = button.titleLabel?.font.withSize(12)
        
    }
    
    private func setupLogoImage() {
        self.addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(15)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.80)
            make.height.equalTo(snp.height).multipliedBy(0.10)
        }
    }
    
    private func setupLogoSubtitleLabel() {
        addSubview(logoSubtitleLabel)
        logoSubtitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(logoImage.snp.bottom).offset(30)
        }
    }
    
    private func setupEmailTextField() {
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(logoSubtitleLabel.snp.bottom).offset(120)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(30)
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
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(emailTextField).offset(70)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(30)        }
    }
    private func setupPasswordLogo(){
        addSubview(passwordLogo)
        passwordLogo.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.right.equalTo(passwordTextField.snp.left).offset(-5)
            make.width.height.equalTo(snp.width).multipliedBy(0.08)
        }
    }
    
    private func setupLowerLoginButton(){
        addSubview(lowerLoginButton)
        lowerLoginButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(passwordTextField.snp.width)
        }
    }
    
}



