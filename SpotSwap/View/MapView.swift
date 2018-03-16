import UIKit
import MapKit
import SnapKit

class MapView: UIView {

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

    // MARK: - Inits
    init(viewController: UIViewController) {
        self.init()
        if let mapViewDelegate = viewController as? MKMapViewDelegate {
            mapView.delegate = mapViewDelegate
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

        let coordinate = Spot(location: touchMapCoordinate, userUID: "TestUserID")
        mapView.addAnnotation(coordinate)
        DataBaseService.manager.addSpot(spot: coordinate)
    }

}
