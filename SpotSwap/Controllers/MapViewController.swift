//
//  MapViewController.swift
//  SpotSwap
//
//  Created by Masai Young on 3/15/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Coord: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String? = "Title"
//    let subtitle: String? = "Subtitle"
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

class MapViewController: UIViewController {
    
    var contentView: MapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavBar()
        prepareContentView()
        LocationService.manager.checkForLocationServices()
    }
    
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Show blue dot for user's current location
        if annotation is MKUserLocation {
            return nil
        }
        
        // Get instance of annotationView so we can modify color
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }

        let detailView = UILabel()
        detailView.text = "Test details" 
        
        annotationView?.markerTintColor = Stylesheet.Colors.BlueMain
        annotationView?.canShowCallout = true
        annotationView?.detailCalloutAccessoryView = detailView
        return annotationView
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.showAnnotations([userLocation], animated: true)
    }

//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        print("Tapped")
//    }
}

