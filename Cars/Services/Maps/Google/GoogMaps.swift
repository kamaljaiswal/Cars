//
//  GoogMaps.swift
//  Cars
//
//  Created by Kamal Jaiswal on 24/02/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation
import GoogleMaps



class GoogMaps:NSObject, Maps {
    typealias MapType = GMSMapView
    public var mapView: GMSMapView!
    
    func setMapView(frame:CGRect) {
        mapView = GMSMapView(frame: frame)
    }
    
    
    func setupMap() {
        let camera = GMSCameraPosition.camera(withLatitude: mapView.myLocation?.coordinate.latitude ?? 0.0 , longitude: mapView.myLocation?.coordinate.longitude ?? 0.0 , zoom: MapConstants.MinZoom)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.rotateGestures = false
        mapView.settings.tiltGestures = false
        mapView.mapType = .normal
        mapView.delegate = self
        
    }
    
    func plotmarkers(locations: [CLLocationCoordinate2D]) {
        var bounds = GMSCoordinateBounds()
        for position in locations {
            let marker = GMSMarker(position: position)
            marker.icon = UIImage(named:"pin_small")
            marker.map = mapView
            bounds = bounds.includingCoordinate(marker.position)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 20)
        mapView.animate(with: update)
    }
    
    func zoom(to cordinate:CLLocationCoordinate2D) {
        let  currentZoom = mapView.camera.zoom
        if (currentZoom < MapConstants.MaxZoom) {
            DispatchQueue.main.async { [weak self] in
                self?.mapView.animate(with: GMSCameraUpdate.setTarget(cordinate, zoom: MapConstants.MaxZoom))
            }
        }
        else {
            DispatchQueue.main.async { [weak self] in
                self?.mapView.animate(with: GMSCameraUpdate.setTarget(cordinate))
            }
        }
    }
    
    
}

extension GoogMaps:GMSMapViewDelegate {
    
}
