//
//  AppMaps.swift
//  Cars
//
//  Created by Kamal Jaiswal on 24/02/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation
import MapKit

class AppMaps:NSObject, Maps {
    typealias MapType = MKMapView
    public var mapView: MKMapView!
    
    func setupMap() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isRotateEnabled = false
    }
    
    func setMapView(frame:CGRect) {
        mapView = MKMapView(frame: frame)
    }
    
    func plotmarkers(locations: [CLLocationCoordinate2D]) {
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: locations[0], span: span)
        mapView.setRegion(region, animated: true)
        
        for position in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = position
            mapView.addAnnotation(annotation)
        }
    }
    
    func zoom(to cordinate:CLLocationCoordinate2D) {
        let viewRegion = MKCoordinateRegionMakeWithDistance(cordinate, 500, 500)
        mapView.setRegion(viewRegion, animated: true)
    }
    
}

extension AppMaps:MKMapViewDelegate {
    
}
