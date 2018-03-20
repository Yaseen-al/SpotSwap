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
        logo.image = #imageLiteral(resourceName: "SpotSwapLogo")
        return logo
    }()
    
    lazy var logoSubtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 21))
        label.backgroundColor = .orange
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Share your parking spot with people nearby"
        return label
    }()
    
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        //frame: CGRect(x: 100, y: 100, width: 100, height: 50)
        button.backgroundColor = Stylesheet.Colors.OrangeMain
        button.layer.borderWidth = 1
        button.layer.borderColor = Stylesheet.Colors.GrayMain.cgColor
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        //frame: CGRect(x: 100, y: 100, width: 100, height: 50)
        button.backgroundColor = Stylesheet.Colors.OrangeMain
        button.layer.borderWidth = 1
        button.layer.borderColor = Stylesheet.Colors.GrayMain.cgColor
        button.setTitle("SignUp", for: .normal)
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
        setupImageView()
        setupLogoImage()
        //setupLogoSubtitleLabel()
        setUpLoginButton()
        setUpSignUpButton()
    }
    
    
    private func setupImageView() {
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(snp.edges)
            //            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            //            make.leading.trailing.bottom.equalTo(self)
        }
    }
    
    private func setupLogoImage() {
        self.addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(snp.width).multipliedBy(0.80)
            make.height.equalTo(snp.height).multipliedBy(0.40)
        }
    }
    
    private func setupLogoSubtitleLabel() {
        self.addSubview(logoSubtitleLabel)
        logoSubtitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    private func setUpLoginButton() {
        self.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.width.equalTo(snp.width).multipliedBy(0.50)
            make.height.equalTo(60)
            make.left.equalTo(snp.left)
            make.bottom.equalTo(snp.bottom)
            
        }
    }
    
    private func setUpSignUpButton() {
        self.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (make) in
            make.width.equalTo(snp.width).multipliedBy(0.50)
            make.height.equalTo(60)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
    }
    
}


//Segmented Control

//    lazy var segmentedControl: UISegmentedControl = {
//        let items = ["Login", "SignUp"]
//        let sc = UISegmentedControl(items: items)
//        sc.selectedSegmentIndex = 0
//        sc.frame = CGRect(x: 0, y: 0, width: 200, height: 21)
//        sc.layer.cornerRadius = 5.0  // Don't let background bleed
//        sc.backgroundColor = .gray
//        sc.tintColor = .white
//        return sc
//    }()
//    private func setupSegmentedControl() {
//        self.addSubview(segmentedControl)
//        segmentedControl.snp.makeConstraints { (make) in
//            make.height.equalTo(snp.height).multipliedBy(0.10)
//            make.leading.bottom.trailing.equalTo(self)
//        }
//    }
