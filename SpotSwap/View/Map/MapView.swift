import UIKit
import MapKit
import SnapKit

protocol MapViewGestureDelegate: class {
    func mapViewWasLongPressed(at location: CLLocationCoordinate2D)
}
protocol ReservationViewDelegate: class {
    func completeReservation()
    func cancelReservation()
}

class MapView: UIView {
    
    weak var gestureDelegate: MapViewGestureDelegate!
    weak var calloutDelegate: ExampleCalloutViewDelegate!
    weak var reservationViewDelegate: ReservationViewDelegate?
    // MARK: - Properties
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        prepareMapToHandleLongPresses(map)
        return map
    }()
    
    lazy var userLocationButton: MKUserTrackingButton = {
        let userLocationButton = MKUserTrackingButton()
        userLocationButton.mapView = mapView
        return userLocationButton
    }()
    //MARK: Reservation Properties
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "defaultProfileImage")
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Yaseen Test"
        return label
    }()
    lazy var timer: UIButton = {
        let bttn = UIButton()
        bttn.layer.cornerRadius = 5
        bttn.layer.masksToBounds = true
        bttn.backgroundColor = Stylesheet.Colors.PinkMain
        return bttn
    }()
    lazy var cancelReservationButton: UIButton = {
        let bttn = UIButton()
        bttn.backgroundColor = Stylesheet.Colors.PinkMain
        bttn.setTitle("Cancel", for: .normal)
        bttn.titleLabel?.font = UIFont(name: Stylesheet.Fonts.Bold, size: 20)
        bttn.titleLabel?.textColor = Stylesheet.Colors.LightGray
        bttn.addTarget(self, action: #selector(cancelReservation(_:)), for: .touchUpInside)
        return bttn
    }()
    lazy var arrivedReservationButton: UIButton = {
        let bttn = UIButton()
        bttn.backgroundColor = Stylesheet.Colors.OrangeMain
        bttn.setTitle("Swap completed", for: .normal)
        bttn.titleLabel?.font = UIFont(name: Stylesheet.Fonts.Bold, size: 20)
        bttn.titleLabel?.textColor = Stylesheet.Colors.LightGray
        bttn.addTarget(self, action: #selector(completeReservation(_:)), for: .touchUpInside)
        return bttn
    }()
    lazy var reservationHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = Stylesheet.Colors.OrangeMain
        return view
    }()
    lazy var reservationFooterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    // MARK: - Inits
    init(viewController: UIViewController) {
        self.init()
        if let mapViewDelegate = viewController as? MKMapViewDelegate,
            let mapViewGestureDelegate = viewController as? MapViewGestureDelegate,
            let mapViewCalloutDelegate = viewController as? ExampleCalloutViewDelegate {
            mapView.delegate = mapViewDelegate
            gestureDelegate = mapViewGestureDelegate
            calloutDelegate = mapViewCalloutDelegate
        }
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
        prepareMap()
        prepareLocationButton()
    }
    
    private func prepareMap() {
        self.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(snp.edges)
        }
    }
    
    private func prepareLocationButton() {
        self.addSubview(userLocationButton)
        userLocationButton.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(30)
            make.bottom.equalTo(snp.bottom).offset(-30)
        }
    }
    private func prepareReservationHeaderView(){
        addSubview(reservationHeaderView)
        reservationHeaderView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.10)
            make.centerX.equalTo(snp.centerX)
        }
    }
    private func prepareProfileImageView() {
        reservationHeaderView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.left.equalTo(reservationHeaderView.snp.left).offset(10)
            make.center.equalTo(reservationHeaderView.snp.center)
            make.size.equalTo(reservationHeaderView.snp.height).multipliedBy(0.85)
        }
    }
    
    private func prepareUserNameLabel() {
        reservationHeaderView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(11)
            make.centerY.equalTo(reservationHeaderView.snp.centerY)
        }
    }
    
    private func prepareTimer() {
        reservationHeaderView.addSubview(timer)
        timer.snp.makeConstraints { make in
            make.right.equalTo(reservationHeaderView.snp.right).offset(-10)
            make.centerY.equalTo(reservationHeaderView.snp.centerY)
            make.height.equalTo(reservationHeaderView.snp.height).multipliedBy(0.65)
            make.width.equalTo(reservationHeaderView.snp.width).multipliedBy(0.20)
        }
    }
    private func prepareReservationFooterView(){
        addSubview(reservationFooterView)
        reservationFooterView.snp.makeConstraints { (make) in
            make.bottom.equalTo(snp.bottom)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.10)
            make.centerX.equalTo(snp.centerX)
        }
    }
    private func prepareArrivedReservationButton(){
    reservationFooterView.addSubview(arrivedReservationButton)
        arrivedReservationButton.snp.makeConstraints { (make) in
            make.top.equalTo(reservationFooterView.snp.top)
            make.left.equalTo(reservationHeaderView.snp.left)
            make.height.equalTo(reservationFooterView.snp.height)
            make.width.equalTo(reservationHeaderView.snp.width).multipliedBy(0.50)
        }
    }
    private func prepareCancelReservaionButton(){
        reservationFooterView.addSubview(cancelReservationButton)
        cancelReservationButton.snp.makeConstraints { (make) in
            make.top.equalTo(reservationFooterView.snp.top)
            make.right.equalTo(reservationHeaderView.snp.right)
            make.height.equalTo(reservationFooterView.snp.height)
            make.width.equalTo(reservationHeaderView.snp.width).multipliedBy(0.50)
        }
    }
    
    public func showReservationView(with vehicleOwner: VehicleOwner, reservation: Reservation){
        userNameLabel.text = vehicleOwner.userName
        timer.setTitle(reservation.duration, for: .normal)
        prepareReservationHeaderView()
        prepareReservationFooterView()
        prepareProfileImageView()
        prepareUserNameLabel()
        prepareTimer()
        prepareArrivedReservationButton()
        prepareCancelReservaionButton()
    }
    public func removeReservationView(){
        reservationHeaderView.removeFromSuperview()
        reservationFooterView.removeFromSuperview()
    }
    //ReservationView Actions
    @objc func cancelReservation(_ sender: UIButton){
        reservationViewDelegate?.cancelReservation()
    }
    @objc func completeReservation(_ sender: UIButton){
        reservationViewDelegate?.completeReservation()
    }
}

// MARK: - Long Press on Map Methods
private extension MapView {
    func prepareMapToHandleLongPresses(_ map: MKMapView) {
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 0.5
        map.addGestureRecognizer(longPressRecogniser)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state != .began { return }
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        gestureDelegate.mapViewWasLongPressed(at: touchMapCoordinate)
    }
    
}
