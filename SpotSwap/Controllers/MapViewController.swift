import UIKit
import MapKit
import CoreLocation

protocol MenuContainerDelegate: class {
    func trigerMenu()
}


class MapViewController: UIViewController {
    
    // MARK: - Properties
    private var initialLaunch = true
    private var contentView = MapView()
    private var reservationDetailView: ReservationDetailView!
    var menuContainerDelegate: MenuContainerDelegate?
    // This is basically an instance of the current vehicle owner in a class that have some functions that helps in controlling the flow of the vehicleOwner operations.
    var vehicleOwnerService: VehicleOwnerService!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupContentView()
        setupDelegates()
        vehicleOwnerService = VehicleOwnerService(self)
        self.view.backgroundColor = Stylesheet.Colors.GrayMain
    }
    
    // MARK: - Setup - View/Data
    private func setupNavigationBar() {
        navigationItem.title = "SpotSwap"
        navigationController?.navigationBar.barTintColor = Stylesheet.Contexts.NavigationController.BarColor
        let listNavigationItem = UIBarButtonItem(image: #imageLiteral(resourceName: "listIcon"), style: .plain, target: self, action: #selector(handleMenu(_:)))
        navigationItem.leftBarButtonItem = listNavigationItem
        // Removes the gloss that makes the nav bar a different shade of the UIColor assigned to it
        navigationController?.navigationBar.isTranslucent = false
        // Removes 1px border line at the bottom of the nav bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    

    private func setupDelegates() {
        LocationService.manager.setDelegate(viewController: self)
    }
    

    private func setupContentView() {
        contentView = MapView(viewController: self)
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    private func setupReservationView(with vehicleOwner: VehicleOwner, reservation: Reservation) {
        //this will make a reservation view with certain data ==> their should be a vehicle owner to get this data from
        reservationDetailView = ReservationDetailView(viewController: self, name: vehicleOwner.userName, time: "6.00")
        //        reservationDetailView.tag =
        self.reservationDetailView.delegate = self
        contentView.addSubview(reservationDetailView)
        reservationDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
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

// MARK: - Delegates
// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
    // Create the pins and the detail view when the pin is tapped
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Show blue dot for user's current location
        if annotation is MKUserLocation {return nil}
        
        // Get instance of annotationView so we can modify color
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MapAnnotationView
        if pin == nil {
            pin = MapAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        }
        
        // Handle if the annotation comes from an open spot, my vehicle location or a spot the user reserved
        pin?.annotation = annotation
        return pin
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
        LocationService.manager.setUserLocation(userLocation)
        setMapRegion(around: userLocation)
    }
    
    func spotsUpdatedFromFirebase(_ spots: [Spot]) {
        guard vehicleOwnerService.getVehicleOwner().reservationId != nil else{
            // Refactor. Should add and remove individual annotation
            contentView.mapView.removeAnnotations(contentView.mapView.annotations)
            contentView.mapView.addAnnotations(spots)
            return
        }
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
    func vehiclOwnerRemoveReservation(_ reservationId: Reservation) {
        //To Do remove the reservationView if it is on the mainView and load all the spots back
    }
    
    func vehicleOwnerSpotReserved(reservationId: String, currentVehicleOwner: VehicleOwner) {
        DataBaseService.manager.retrieveReservation(reservationId: reservationId, dataBaseObserveType: .singleEvent, completion: { reservation in
            //Adding annotaion for the reservation
            let reservationAnnotation = MKPointAnnotation()
            reservationAnnotation.coordinate = CLLocationCoordinate2D(latitude: reservation.latitude, longitude: reservation.longitude)
            
            self.contentView.mapView.removeAnnotations(self.contentView.mapView.annotations)
            self.contentView.mapView.addAnnotation(reservationAnnotation)
            
            //This will check to setup the reservationDetailView a. if the current user is the spot owner or b. if the current user is the reserver
            if reservation.takerId == currentVehicleOwner.userUID {
                DataBaseService.manager.retrieveVehicleOwner(vehicleOwnerId: reservation.spotOwnerId, dataBaseObserveType: .singleEvent, completion: {(vehicleOwnerTaker) in
                    
                    self.setupReservationView(with: vehicleOwnerTaker, reservation: reservation)
                }, errorHandler: { (error) in
                    //this will give an alert to the user in case the taker data can't be retrieved
                    self.alertWithOkButton(title: "there was an error retrieving your matched spot taker", message: nil)
                    return
                })
            } else {
                DataBaseService.manager.retrieveVehicleOwner(vehicleOwnerId: reservation.takerId, dataBaseObserveType: .singleEvent, completion: {(spotOwnerVehicleOwner) in
                    
                    self.setupReservationView(with: spotOwnerVehicleOwner, reservation: reservation)
                }, errorHandler: { (error) in
                    //this will give an alert to the user in case the taker data can't be retrieved
                    self.alertWithOkButton(title: "there was an error retrieving your matched spot owner", message: nil)
                    return
                })
            }
            // Here we need to a. setup the reservationView for the reserver and for the spot owner b. clear all the map from anotation c. have a cancel button to cancel the whole reservation and retrieve back the normal map
            
        }) { (error) in
            print(error)
        }
    }
    
    private func alertWithOkButton(title: String, message: String?){
        let alerViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alerViewController.addAction(okAction)
        self.present(alerViewController, animated: true, completion: nil)
    }
    
    func vehiclOwnerHasNoReservation() {
        guard let _ = reservationDetailView else { return }
        if reservationDetailView.isDescendant(of: view) {
            alertWithOkButton(title: "Reservation was canceled or completed", message: nil)
            reservationDetailView.removeFromSuperview()
        }
        
        //This will load all the spots and load the default map, may be we can a cool sppinner
    }
}

//MARK: - DetailReservation Delegate
extension MapViewController: ReserVationDetailViewDelegate {
    func prepareReservationAction() {
        vehicleOwnerService.removeReservation { (reservation) in
//            LocationService.manager.addSpotsFromFirebaseToMap()
        }
        reservationDetailView.removeFromSuperview()
    }
}


//MARK: - Menu ContainerDelegate Delegate
extension MapViewController {
    @objc private func handleMenu(_ sender: UIBarButtonItem){
        menuContainerDelegate?.trigerMenu()
        
    }
}

//MARK: - ExampleCalloutView Delegate
extension MapViewController: ExampleCalloutViewDelegate {
    func reserveButtonPressed(spot: Spot) {
        print("Reserved")
        vehicleOwnerService.reserveSpot(spot)
    }
}
