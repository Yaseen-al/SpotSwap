//
//  LocationServices.swift
//  SpotSwap
//
//  Created by Masai Young on 3/15/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.

import Foundation
import MapKit
import CoreLocation

protocol LocationServiceDelegate: class {
    func userLocationDidUpdate(_ userLocation: CLLocation)
}

class LocationService: NSObject {
    // Singleton for location services
    static let manager = LocationService()
    private var locationManager: CLLocationManager!
    private weak var locationServiceDelegate: LocationServiceDelegate!
    
    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 100
    }
    
    func setDelegate(viewController: LocationServiceDelegate) {
        locationServiceDelegate = viewController
    }
    
}

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
