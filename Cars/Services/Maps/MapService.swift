//
//  MapService.swift
//  Cars
//
//  Created by Kamal Jaiswal on 11/02/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation
import GoogleMaps



class MapService:NSObject {
    var mapView:GMSMapView
    init(container:UIView) {
        mapView = GMSMapView(frame: container.bounds)
        container.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        container.addConstraint(NSLayoutConstraint(item: container, attribute: .top, relatedBy: .equal, toItem: mapView, attribute: .top, multiplier: 1.0, constant: 0))
        container.addConstraint(NSLayoutConstraint(item: container, attribute: .leading, relatedBy: .equal, toItem: mapView, attribute: .leading, multiplier: 1.0, constant: 0))
        container.addConstraint(NSLayoutConstraint(item: container, attribute: .trailing, relatedBy: .equal, toItem: mapView, attribute: .trailing, multiplier: 1.0, constant: 0))
        container.addConstraint(NSLayoutConstraint(item: container, attribute: .bottom , relatedBy: .equal, toItem: mapView, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    
    func setupMap()  {
        let camera = GMSCameraPosition.camera(withLatitude: mapView.myLocation?.coordinate.latitude ?? 0.0 , longitude: mapView.myLocation?.coordinate.longitude ?? 0.0 , zoom: MapConstants.MinZoom)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.rotateGestures = false
        mapView.settings.tiltGestures = false
        mapView.mapType = .normal
        mapView.delegate = self
        
    }
    
    func plotmarkers(locations: [CLLocationCoordinate2D])  {
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
    
    func zoom(to cordinate:CLLocationCoordinate2D)  {
        mapView.animate(with: GMSCameraUpdate.setTarget(cordinate, zoom: MapConstants.MaxZoom))
    }
    
    
}

extension MapService:GMSMapViewDelegate {
    
}
