import UIKit
import SnapKit
protocol ReserVationDetailViewDelegate: class {
    func prepareReservationAction()
    
}
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
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = Stylesheet.Colors.OrangeMain
        return view
    }()
    // this will either cancel current reservation or end it if the user arrived to the reserved spot
    lazy var reservationAction: UIButton = {
        let bttn = UIButton()
        bttn.backgroundColor = Stylesheet.Colors.PinkMain
        bttn.setTitle("Arrived/Cancel", for: .normal)
        bttn.titleLabel?.font = UIFont(name: Stylesheet.Fonts.Bold, size: 20)
        bttn.titleLabel?.textColor = Stylesheet.Colors.LightGray
        bttn.addTarget(self, action: #selector(prepareReservationAction(_:)), for: .touchUpInside)
        return bttn
    }()
    weak var delegate: ReserVationDetailViewDelegate?
    // MARK: - Inits
    init(viewController: UIViewController, name: String, time: String) {
        self.init()
        userNameLabel.text = name
        timer.setTitle(time, for: .normal)
        prepareViews()
        self.backgroundColor = .clear
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
        prepareHeaderView()
        prepareImageView()
        prepareNameLabel()
        prepareTimer()
        prepareReservationAction()
    }
    private func prepareHeaderView(){
        addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).dividedBy(10)
            make.centerX.equalTo(snp.centerX)
        }
    }
    private func prepareImageView() {
        headerView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalTo(headerView.snp.left).offset(10)
            make.center.equalTo(headerView.snp.center)
            make.size.equalTo(headerView.snp.height).multipliedBy(0.7)
        }
    }
    
    private func prepareNameLabel() {
        headerView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(11)
            make.centerY.equalTo(headerView.snp.centerY)
        }
    }
    
    private func prepareTimer() {
        headerView.addSubview(timer)
        timer.snp.makeConstraints { make in
            make.right.equalTo(headerView.snp.right).offset(-10)
            make.centerY.equalTo(headerView.snp.centerY)
            make.height.equalTo(imageView.snp.height).dividedBy(2)
            make.width.equalTo(imageView.snp.width)
        }
    }
    private func prepareReservationAction(){
        addSubview(reservationAction)
        reservationAction.snp.makeConstraints { (make) in
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.10)
            make.bottom.equalTo(snp.bottom)
            make.centerX.equalTo(snp.centerX)
        }
    }
    @objc func prepareReservationAction(_ sender: UIButton){
        delegate?.prepareReservationAction()
    }
    
}
