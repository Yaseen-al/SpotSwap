
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
        view.backgroundColor = UIColor(red: 205/255, green: 205/255, blue: 212/255, alpha: 0.80)//UIColor.lightGray
        //view.alpha = 0.80
        return view
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)//boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        //label.text = "This parking app does this and that and that and this"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    lazy var tutorialImageView: UIImageView = {
        let logo = UIImageView()
        //logo.image = UIImage(named: "MapShot")
        logo.contentMode = .scaleAspectFit
        //style details
        logo.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        logo.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        logo.layer.shadowOpacity = 1.0
        logo.layer.shadowRadius = 0.0
//        logo.clipsToBounds = false
//        logo.layer.masksToBounds = false
        return logo
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.pageIndicatorTintColor = Stylesheet.Colors.PinkMain
        pc.currentPageIndicatorTintColor = Stylesheet.Colors.OrangeMain
        pc.transform = CGAffineTransform(scaleX: 2, y: 2) //1.3// set dot scale of pageControl
        //pc.backgroundColor = UIColor.darkGray //optional to use
        return pc
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = nil
        //button.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton() //frame: CGRect(x: 100, y: 100, width: 100, height: 50)
        button.backgroundColor = Stylesheet.Colors.BlueMain
        button.setTitle("Start", for: .normal)
        //set button design
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.shadowOpacity = 1.0
        button.layer.cornerRadius = 5
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
        setupNextButton()
        setupImageView()
        setupBottomView()
        setupBottomHeaderLabel()
        setupBottomDescriptionLabel()
        setupPageControl()
        setupStartButton()
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
    
    func setupImageView() {
        addSubview(tutorialImageView)
        tutorialImageView.snp.makeConstraints { (make) in
            make.height.equalTo(snp.height).multipliedBy(0.80)
            make.width.equalTo(snp.width).multipliedBy(0.80)
            make.centerX.equalTo(snp.centerX)
            //make.centerY.equalTo(snp.centerY)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
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
            make.top.equalTo(bottomView.snp.top).offset(70)
            make.width.equalTo(bottomView.snp.width).offset(-20)
            make.centerX.equalTo(bottomView.snp.centerX)
        }
    }
    
    func setupPageControl() {
        addSubview(pageControl) //delete bottomview.
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomView.snp.centerX)
            make.bottom.equalTo(bottomView.snp.bottom).offset(-5)
            make.width.equalTo(bottomView.snp.width)
            //make.height.equalTo(bottomView.snp.height).multipliedBy(0.05)
        }
    }


    
    func setupNextButton() {
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(snp.width).multipliedBy(0.20)
            make.right.equalTo(safeAreaLayoutGuide.snp.right)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
    
    func setupStartButton() {
        self.addSubview(startButton)
        startButton.snp.makeConstraints { (make) in
            make.width.equalTo(bottomView.snp.width).multipliedBy(0.80)
            make.height.equalTo(60)
            make.centerX.equalTo(bottomView.snp.centerX)
            make.centerY.equalTo(bottomView.snp.centerY)
        }
    }
    
}

