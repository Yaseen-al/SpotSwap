import UIKit
import SnapKit

class LaunchView: UIView {
    
    // MARK: - Properties
    lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "launchImage ")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        logo.image = UIImage(named: "43iosgroup6logo")
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
        label.text = "Share your parking with people nearby"
        label.font = UIFont(name: Stylesheet.Fonts.Bold, size: 20)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var tutorialButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Stylesheet.Colors.PinkMain
        button.layer.borderWidth = 1
        button.layer.borderColor = Stylesheet.Colors.GrayMain.cgColor
        button.setTitle("Take a look inside", for: .normal)
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Stylesheet.Colors.OrangeMain
        button.titleLabel?.font = UIFont(name: Stylesheet.Fonts.Bold, size: 20)
        button.titleLabel?.textColor = Stylesheet.Colors.LightGray
        button.titleLabel?.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.layer.borderColor = Stylesheet.Colors.GrayMain.cgColor
        button.layer.shadowColor = Stylesheet.Colors.GrayMain.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.shadowOpacity = 1.0
        
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Stylesheet.Colors.PinkMain
        button.titleLabel?.font = UIFont(name: Stylesheet.Fonts.Bold, size: 20)
        button.titleLabel?.textColor = Stylesheet.Colors.LightGray
        button.titleLabel?.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.layer.borderColor = Stylesheet.Colors.GrayMain.cgColor
        button.layer.shadowColor = Stylesheet.Colors.GrayMain.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.shadowOpacity = 1.0

        button.setTitle("SignUp", for: .normal)
        return button
    }()
    
    lazy var buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup Views
    private func prepareViews() {
        setupImageView()
        setupLogoImage()
        //setupLogoSubtitleLabel()
        setupTutorialButton()
        setupLogoSubtitleLabel()
        setupButtonContainerView()
         setUpLoginButton()
        setUpSignUpButton()
    }
    
    
    private func setupImageView() {
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(snp.edges)
        }
    }
    
    private func setupLogoImage() {
        self.addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(snp.width).multipliedBy(0.85)
            make.height.equalTo(snp.height).multipliedBy(0.25)
        }
    }
    
    private func setupLogoSubtitleLabel() {
        self.addSubview(logoSubtitleLabel)
        logoSubtitleLabel.snp.makeConstraints { (make) in
           make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.90)
        }
    }
    private func setupButtonContainerView(){
        addSubview(buttonContainerView)
        buttonContainerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(snp.bottom)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.10)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    private func setupTutorialButton() {
        self.addSubview(tutorialButton)
        tutorialButton.snp.makeConstraints { (make) in
            make.width.equalTo(snp.width).multipliedBy(0.50)
            make.height.equalTo(30)
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(snp.bottom).offset(-80)
        }
    }
    
    private func setUpLoginButton() {
        self.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.width.equalTo(buttonContainerView.snp.width).multipliedBy(0.50)
            make.height.equalTo(buttonContainerView.snp.height)
            make.left.equalTo(buttonContainerView.snp.left)
            make.bottom.equalTo(buttonContainerView.snp.bottom)
            
        }
    }
    private func setUpSignUpButton() {
        buttonContainerView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (make) in
            make.width.equalTo(buttonContainerView.snp.width).multipliedBy(0.50)
            make.height.equalTo(buttonContainerView.snp.height)
            make.right.equalTo(buttonContainerView.snp.right)
            make.bottom.equalTo(buttonContainerView.snp.bottom)
        }
    }
    
}

