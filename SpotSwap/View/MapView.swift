//
//  MapView.swift
//  SpotSwap
//
//  Created by Masai Young on 3/15/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class MapView: UIView {
    
    // MARK: - Properties
    var parentViewController: UIViewController!
    
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
        userLocationButton.backgroundColor = Stylesheet.Colors.OrangeMain
        userLocationButton.layer.borderColor = UIColor.gray.cgColor
        userLocationButton.layer.borderWidth = 0.5
        userLocationButton.layer.cornerRadius = 5.0
        userLocationButton.layer.masksToBounds = true
        return userLocationButton
    }()
    
    // MARK: - Inits
    init(viewController: UIViewController) {
        self.init()
        if let mapViewDelegate = viewController as? MKMapViewDelegate {
            parentViewController = viewController
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

// MARK: - Private helper functions for handling long presses on map
private extension MapView {
    func prepareMapToHandleLongPresses(_ map: MKMapView) {
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 0.5
        map.addGestureRecognizer(longPressRecogniser)
    }
    
    @objc func handleLongPress(_ gestureRecognizer : UIGestureRecognizer) {
        if gestureRecognizer.state != .began { return }
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let coordinate = Coord(coordinate: touchMapCoordinate)
        mapView.addAnnotation(coordinate)
    }
    
    
}

