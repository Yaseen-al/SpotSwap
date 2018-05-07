import UIKit
import SnapKit

protocol ProfileViewDelegate: class {
    func profileImageTapGesture()
    func backButton()
}

final class ProfileView: UIView, UIGestureRecognizerDelegate {
    
    
//    lazy var profileNameLabel: UILabel = {
//        let lbl = UILabel()
//        return lbl
//    }()
    
    
    lazy var backImageButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var settingsTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    lazy var profileBGImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "defaultVehicleImage")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeVehicleImage))
        tapGesture.delegate = self
        imageView.isUserInteractionEnabled = true //essential for the tapGesture to work
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "defaultProfileImage")
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        tapGesture.delegate = self
        imageView.isUserInteractionEnabled = true //essential for the tapGesture to work
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    init(_ vehicleOwner: VehicleOwner){
        self.init()
//        userNameLabel.text = vehicleOwner.userName
//        userPointsLabel.text = "Reward Points: " + vehicleOwner.rewardPoints.description
        guard let imageUrl = vehicleOwner.userImage else{
            return
        }
        StorageService.manager.retrieveImage(imgURL: imageUrl, completionHandler: { (profileImage) in
            self.profileImage.image = profileImage
        }) { (error) in
            print(error)
        }
       fetchVehicleImage(vehicleOwner: vehicleOwner)
    }
    
    private func fetchVehicleImage(vehicleOwner: VehicleOwner) {
        StorageService.manager.retrieveImage(imgURL: vehicleOwner.car.carImageId, completionHandler: { [weak self] image in
            self?.profileBGImageView.image = image
        }) { [weak self] error in
            self?.profileBGImageView.backgroundColor = .red
            print(error)
        }
    }
    
    
    // MARK: - Delegates
    weak var profileViewDelegate: ProfileViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = Stylesheet.Colors.GrayMain
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layer.cornerRadius = profileImage.bounds.width/2.0
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 4
    }
    
    private func setupViews() {
        setupProfileBGImageView()
        setupUserProfileImageView()
        setupBackButton()
    }
    
    private func setupBackButton() {
        addSubview(backImageButton)
        backImageButton.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
        }
    }
    
    private func setupProfileBGImageView() {
        addSubview(profileBGImageView)
        profileBGImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.3)
        }
    }
    
    private func setupUserProfileImageView() {
        addSubview(profileImage)
        profileImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileBGImageView.snp.bottom)
            make.centerX.equalTo(profileBGImageView.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.25)
            make.height.equalTo(profileImage.snp.width)
        }
    }
    
    
    @objc private func changeVehicleImage() {
        profileViewDelegate?.profileImageTapGesture()
    }
    @objc private func changeProfileImage() {
        profileViewDelegate?.profileImageTapGesture()
    }
    @objc private func backButtonClicked() {
        profileViewDelegate?.backButton()
    }
    
}






