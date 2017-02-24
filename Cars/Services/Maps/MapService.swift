//
//  MapService.swift
//  Cars
//
//  Created by Kamal Jaiswal on 11/02/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation
import MapKit


public protocol Maps {
    associatedtype MapType
    var mapView:MapType! { set get }
    
    func setupMap()
    func setMapView(frame:CGRect)
    func plotmarkers(locations: [CLLocationCoordinate2D])
    func zoom(to cordinate:CLLocationCoordinate2D)
    
}

class MapService<MapType:Maps> {
    
    var map:MapType?
    init(container:UIView,mapType:MapType) {
        map = mapType
        map?.setMapView(frame: container.bounds)
        if let mapV = map?.mapView as? UIView {
            container.addSubview(mapV)
            mapV.translatesAutoresizingMaskIntoConstraints = false
            container.addConstraint(NSLayoutConstraint(item: container, attribute: .top, relatedBy: .equal, toItem: mapV, attribute: .top, multiplier: 1.0, constant: 0))
            container.addConstraint(NSLayoutConstraint(item: container, attribute: .leading, relatedBy: .equal, toItem: mapV, attribute: .leading, multiplier: 1.0, constant: 0))
            container.addConstraint(NSLayoutConstraint(item: container, attribute: .trailing, relatedBy: .equal, toItem: mapV, attribute: .trailing, multiplier: 1.0, constant: 0))
            container.addConstraint(NSLayoutConstraint(item: container, attribute: .bottom , relatedBy: .equal, toItem: mapV, attribute: .bottom, multiplier: 1.0, constant: 0))
        }
    }
    
    func setupMap()  {
        map?.setupMap()
    }
    func plotmarkers(locations: [CLLocationCoordinate2D])  {
        map?.plotmarkers(locations: locations)
    }
    
    func zoom(to cordinate:CLLocationCoordinate2D)  {
        map?.zoom(to: cordinate)
    }
}
