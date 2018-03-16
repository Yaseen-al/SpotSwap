import Foundation
import MapKit
import CoreLocation

protocol LocationServiceDelegate: class {
    func userLocationDidUpdate(_ userLocation: CLLocation)
}

class LocationService: NSObject {
    
    // MARK: - Properties
    // Apple suggest to only have one instance of CLLocationManager
    static let manager = LocationService()
    private var locationManager: CLLocationManager!
    private weak var locationServiceDelegate: LocationServiceDelegate!
    
    // MARK: - Inits
    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 10
        checkForLocationServices()
    }
    
    // MARK: - Public Methods
    func setDelegate(viewController: LocationServiceDelegate) {
        locationServiceDelegate = viewController
    }
    
    // MARK: - Private Methods
    private func checkForLocationServices() {
        let phoneLocationServicesAreEnabled = CLLocationManager.locationServicesEnabled()
        if phoneLocationServicesAreEnabled {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined: // intial state on first launch
                print("not determined")
                locationManager.requestWhenInUseAuthorization()
            case .denied: // user could potentially deny access
                print("denied")
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways:
                print("authorizedAlways")
            case .authorizedWhenInUse:
                print("authorizedWhenInUse")
            default:
                break
            }
        }
    }
    
}

// MARK: - CLLocationManagerDelegate Methods
extension LocationService: CLLocationManagerDelegate {
    
    // This method is called once when app loads, responsible for `startUpdatingLocation`
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            print("Auth Status changed. Authorized")
        default:
            locationManager.stopUpdatingLocation()
            print("Auth Status changed. No longer allowed")
        }
    }
    
    // Handles user location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }
        locationServiceDelegate.userLocationDidUpdate(userLocation)
        print("Updated locations: \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
}
