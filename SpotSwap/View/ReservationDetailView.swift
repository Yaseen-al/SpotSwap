import UIKit
import SnapKit

class ReservationDetailView: UIView {
    
    // MARK: - Properties
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .green
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var timer: UIButton = {
        let bttn = UIButton()
        bttn.layer.cornerRadius = 5
        bttn.layer.masksToBounds = true
        bttn.backgroundColor = Stylesheet.Colors.PinkMain
        return bttn
    }()
    
    // MARK: - Inits
    init(viewController: UIViewController, name: String, time: String) {
        self.init()
        userNameLabel.text = name
        timer.setTitle(time, for: .normal)
        prepareViews()
        self.backgroundColor = Stylesheet.Colors.OrangeMain
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup View/Data
    private func prepareViews() {
        prepareImageView()
        prepareNameLabel()
        prepareTimer()
    }
    
    private func prepareImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(10)
            make.center.equalTo(snp.center)
            make.size.equalTo(snp.height).multipliedBy(0.7)
        }
    }
    
    private func prepareNameLabel() {
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(11)
            make.centerY.equalTo(snp.centerY)
        }
    }
    
    private func prepareTimer() {
        addSubview(timer)
        timer.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-10)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(imageView.snp.height).dividedBy(2)
            make.width.equalTo(imageView.snp.width)
        }
    }
    
    
}
