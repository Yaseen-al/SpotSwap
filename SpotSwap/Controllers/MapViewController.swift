import UIKit
import MapKit
import CoreLocation

class Coord: NSObject, MKAnnotation {
    enum CoordType {
        case availableSpot
        case spotReservedForUser
        case locationOfVehicle
    }

    var coordinate: CLLocationCoordinate2D
    var title: String? = "Title"
    var type: CoordType

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = Coord.randomTimeForSpot()
        self.type = Coord.randomTypeOfCoordinate()
    }

    // Temporary functions for testing
    private static func randomTimeForSpot(_ upperlimit: Int = 5) -> String {
        let seconds = ["05", "15", "30", "45"]
        let randomIndex = Int(arc4random_uniform(4))

        let randomMinute = arc4random_uniform(4) + 1
        let randomSeconds = seconds[randomIndex]

        let time = "\(randomMinute):\(randomSeconds)"
        return time
    }

    private static func randomTypeOfCoordinate() -> CoordType {
        let randomIndex = Int(arc4random_uniform(3))
        let randomTypes: [CoordType] = [.availableSpot, .spotReservedForUser, .locationOfVehicle]
        return randomTypes[randomIndex]
    }
}

class MapViewController: UIViewController {

    // MARK: - Properties
    var contentView: MapView!
    private var initialLaunch = true

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavBar()
        prepareContentView()
        LocationService.manager.setDelegate(viewController: self)
    }

    // MARK: - Setup - View/Data
    private func prepareNavBar() {
        navigationItem.title = "SpotSwap"
        navigationController?.navigationBar.barTintColor = Stylesheet.Contexts.NavigationController.BarColor
    }

    private func prepareContentView() {
        contentView = MapView(viewController: self)
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }

}

extension MapViewController: MKMapViewDelegate {

    // Create the pins and the detail view when the pin is tapped
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        // Show blue dot for user's current location
        if annotation is MKUserLocation {
            return nil
        }

        // Get instance of annotationView so we can modify color
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        }

        // Handle if the annotation comes from an open spot, my vehicle location or a spot the user reserved
        switch annotation {
        case is Coord:
            // TODO: - Create custom detail view, inject it with `annotation` for data.
            let detailView = UILabel()
            let lat = String(annotation.coordinate.latitude).prefix(5)
            let long = String(annotation.coordinate.longitude).prefix(5)
            detailView.text = "LAT: \(lat), LONG: \(long)"

            // Testing
            let coordAnnotation = annotation as! Coord
            switch coordAnnotation.type {
            case .availableSpot:
                annotationView?.markerTintColor = Stylesheet.Colors.BlueMain
            case .spotReservedForUser:
                annotationView?.markerTintColor = Stylesheet.Colors.PinkMain
            case .locationOfVehicle:
                annotationView?.markerTintColor = Stylesheet.Colors.OrangeMain
            }

            annotationView?.annotation = annotation
            annotationView?.canShowCallout = true
            annotationView?.detailCalloutAccessoryView = detailView
        default:
            break
        }

        return annotationView
    }
}

extension MapViewController: LocationServiceDelegate {
    func userLocationDidUpdate(_ userLocation: CLLocation) {
        setMapRegion(around: userLocation)
    }
}

// MARK: - Map helper functions
private extension MapViewController {
    func setMapRegion(around location: CLLocation) {
        if initialLaunch == true {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            contentView.mapView.setRegion(region, animated: true)
            
            initialLaunch = false
        }
    }
}
