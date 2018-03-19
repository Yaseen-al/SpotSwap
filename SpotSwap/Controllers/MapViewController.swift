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
        testCreateAccount()
        view.addSubview(reservationDetailView)
        vehicleOwnerService = VehicleOwnerServices(self)
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
    
    private func prepareReservationDetailView() {
        reservationDetailView = ReservationDetailView(viewController: self, name: "Sai", time: "6.00")
        view.addSubview(reservationDetailView)
        reservationDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height).dividedBy(8)
        }
    }
    
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
            // TODO: - Create custom detail view, inject it with `annotation` for data.
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
        // Testing reserving a spot
        // let coord = Coord(coordinate: view.annotation!.coordinate)
        let userHasNoCurrentReservation = !vehicleOwnerService.hasReservation()
        if let spot = view.annotation as? Spot {
            reserveSpot(spot)
        }
    }
    
    private func reserveSpot(_ spot: Spot) {
        let currentUserReservingASpot = vehicleOwnerService.getVehicleOwner()
        let reservation = Reservation(makeFrom: spot, reservedBy: currentUserReservingASpot)
        
        contentView.mapView.removeAnnotation(spot)
        DataBaseService.manager.removeSpot(spotId: spot.spotUID)
        
        spot.reservationUID = spot.spotUID
        DataBaseService.manager.addSpot(spot: spot)
        DataBaseService.manager.addReservation(reservation: reservation, to: currentUserReservingASpot)
        DataBaseService.manager.addNewVehicleOwner(vehicleOwner: currentUserReservingASpot, userID: currentUserReservingASpot.userUID)
    }

}

extension MapViewController: LocationServiceDelegate {
    func userLocationDidUpdate(_ userLocation: CLLocation) {
        setMapRegion(around: userLocation)
    }
    
    func spotsUpdatedFromFirebase(_ spots: [Spot]) {
        // TODO: - Refactor. Should add and remove individual annotation
        contentView.mapView.removeAnnotations(contentView.mapView.annotations)
        contentView.mapView.addAnnotations(spots)
    }
    
}

extension MapViewController: MapViewGestureDelegate {
    func mapViewWasLongPressed(at location: CLLocationCoordinate2D) {
        let newSpot = Spot(location: location)
        DataBaseService.manager.addSpot(spot: newSpot)
    }
}

extension MapViewController: VehicleOwnerServiceDelegate {
    
    func retrieveReservations(reservationID: String, completion: @escaping (Reservation)->Void , errorHandler: @escaping (Error)->Void) {
        let reservationRef = DataBaseService.manager.getReservationsRef().child(reservationID)
        reservationRef.observe(.value) { (snapShot) in
            if let json = snapShot.value {
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let reservation = try JSONDecoder().decode(Reservation.self, from: jsonData)
                    completion(reservation)
                }
                catch{
                    print(#function, error)
                    errorHandler(UserDataBaseErrors.errorDecodingVehicleOwner)
                }
            }
        }
    }
    
    func vehicleOwnerReservationDidUpdate(_ reservation: String) {
        retrieveReservations(reservationID: reservation, completion: { [weak self] reservation in
            self?.reservationDetailView.userNameLabel.text = reservation.takerUID
            self?.reservationDetailView.timer.setTitle(reservation.duration, for: .normal)
        }) { (error) in
            print(error)
        }
    }
}

// MARK: - Map helper functions
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
