import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    // MARK: - Properties
    var contentView: MapView!
    var reservationDetailView: ReservationDetailView!
    
    var vehicleOwnerService: VehicleOwnerServices!
    
    private var initialLaunch = true
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavBar()
        prepareContentView()
        prepareReservationDetailView()
        LocationService.manager.setDelegate(viewController: self)
        vehicleOwnerService = VehicleOwnerServices(self)
        
        testCreateAccount()
    }
    
    // MARK: - Setup - View/Data
    private func prepareNavBar() {
        navigationItem.title = "SpotSwap"
        navigationController?.navigationBar.barTintColor = Stylesheet.Contexts.NavigationController.BarColor
        
        // Removes the gloss that makes the nav bar a different shade of the UIColor assigned to it
        navigationController?.navigationBar.isTranslucent = false
        
        // Removes 1px border line at the bottom of the nav bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func prepareContentView() {
        contentView = MapView(viewController: self)
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    private func prepareReservationDetailView() {
        reservationDetailView = ReservationDetailView(viewController: self, name: "Sai", time: "6.00")
        view.addSubview(reservationDetailView)
        reservationDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height).dividedBy(10)
        }
    }
    
    // TESTING - REMOVE
    func testCreateAccount(){
        let userEmail = "SaiTesting20@gmail.com"
        let userPassword = "newPassword135"
        AuthenticationService.manager.createUser(email: userEmail, password: userPassword, completion: { [weak self] (user) in
            
            let myCar = Car(carMake: "BMW", carModel: "E30", carYear: "1988", carImageId: nil)
            let vehicleOwner = VehicleOwner(user: user, car: myCar, userName: userEmail)
            DataBaseService.manager.addNewVehicleOwner(vehicleOwner: vehicleOwner, user: user, completion: {
                print(#function, "added vehicle owner to the dataBase \(vehicleOwner.userName)")
                self?.vehicleOwnerService.fetchVehicleOwnerFromFirebase()
            }, errorHandler: { (error) in
                print("error in adding a vehicle owner to the data base")
            })
        }) { [weak self] (error) in
            print(#function, error)
            self?.vehicleOwnerService.fetchVehicleOwnerFromFirebase()
        }
    }
    
}

// MARK: - MKMapViewDelegate
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
        case is Spot:
            let spot = annotation as! Spot
            // Create custom detail view, inject it with `annotation` for data.
            let detailView = UILabel()
            let lat = String(annotation.coordinate.latitude).prefix(5)
            let long = String(annotation.coordinate.longitude).prefix(5)
            
            
            if let reservationID = spot.reservationUID {
                annotationView?.markerTintColor = Stylesheet.Colors.PinkMain
                detailView.text = """
                Reserved by \(reservationID.prefix(5)) 💩
                You have \(spot.duration) minutes!
                """
            } else {
                annotationView?.markerTintColor = Stylesheet.Colors.BlueMain
                detailView.text = "LAT: \(lat), LONG: \(long)"
            }
            
            
            annotationView?.annotation = annotation
            annotationView?.canShowCallout = true
            annotationView?.detailCalloutAccessoryView = detailView
            
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        default:
            break
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // TESTING - enable this line to simulate real use case of only being able to reserve a single spot at a time
        // let userHasNoCurrentReservation = !vehicleOwnerService.hasReservation()
        if let spot = view.annotation as? Spot {
            vehicleOwnerService.reserveSpot(spot)
        }
    }
    
}

// MARK: - LocationServiceDelegate
extension MapViewController: LocationServiceDelegate {
    func userLocationDidUpdate(_ userLocation: CLLocation) {
        setMapRegion(around: userLocation)
    }
    
    func spotsUpdatedFromFirebase(_ spots: [Spot]) {
        // Refactor. Should add and remove individual annotation
        contentView.mapView.removeAnnotations(contentView.mapView.annotations)
        contentView.mapView.addAnnotations(spots)
    }
    
}

// MARK: - MapViewGestureDelegate
extension MapViewController: MapViewGestureDelegate {
    func mapViewWasLongPressed(at location: CLLocationCoordinate2D) {
        let newSpot = Spot(location: location)
        DataBaseService.manager.addSpot(spot: newSpot)
    }
}

// MARK: - VehicleOwnerServiceDelegate
extension MapViewController: VehicleOwnerServiceDelegate {
    func vehicleOwnerReservationDidUpdate(_ reservation: String) {
        DataBaseService.manager.retrieveReservations(reservationID: reservation, completion: { [weak self] reservation in
            self?.reservationDetailView.userNameLabel.text = reservation.takerUID.prefix(6).description
            self?.reservationDetailView.timer.setTitle(reservation.duration, for: .normal)
        }) { (error) in
            print(error)
        }
    }
}

// MARK: - Map Helper Functions
private extension MapViewController {
    func setMapRegion(around location: CLLocation) {
        if initialLaunch {
            let regionArea = 0.02 // smaller is more zoomed in
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: regionArea, longitudeDelta: regionArea))
            contentView.mapView.setRegion(region, animated: true)
            initialLaunch = false
        }
    }
}
