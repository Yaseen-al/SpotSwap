
import UIKit
import SnapKit

class WalkthroughView: UIView {
    
    // MARK: - Properties
    lazy var mainContentView:UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.alpha = 0.50
        return view
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This parking app does this and that and that and this"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var imageView: UIImageView = {
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
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        return pc
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .blue//Stylesheet.Colors.BlueMain
        button.setTitle("next", for: .normal)
        return button
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .blue//Stylesheet.Colors.BlueMain
        button.setTitle("Start", for: .normal)
        return button
    }()
    
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareMainView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup Views
    private func prepareMainView() {
        setupBottomView()
        setupBottomHeaderLabel()
        setupBottomDescriptionLabel()
        setupPageControl()
    }
    
    func setupBottomView() {
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.30)
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(snp.bottom)
        }
    }
    func setupBottomHeaderLabel() {
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bottomView.snp.top).offset(5)
            make.width.equalTo(bottomView.snp.width)
            make.centerX.equalTo(bottomView.snp.centerX)
        }
    }
    
    func setupBottomDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bottomView.snp.top).offset(50)
            make.width.equalTo(bottomView.snp.width)
            make.centerX.equalTo(bottomView.snp.centerX)
        }
    }
    
    func setupPageControl() {
        bottomView.addSubview(pageControl) //delete bottomview.
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomView.snp.centerX)
            make.bottom.equalTo(bottomView.snp.bottom).offset(-5)
            make.width.equalTo(bottomView.snp.width)
            //make.height.equalTo(bottomView.snp.height).multipliedBy(0.05)
        }
    }

    private func setupImageView() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            
        }
    }

    
    private func setupNextButton() {
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            
        }
    }
    
    private func setupStartButton() {
        self.addSubview(startButton)
        startButton.snp.makeConstraints { (make) in
            
        }
    }
    
}

