//
//  CarViewModel.swift
//  Cars
//
//  Created by Kamal Jaiswal on 11/02/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation


class CarViewModel {
    
    var cars:[Car] = [Car]()
    var sectionsData:[String:[Car]]? =  [String:[Car]]()
    
    func load(cars completion:@escaping (Error?) -> ())  {
        NetworkService.fetch { (response, error) in
            guard error == nil , let value = response else {
                completion(error)
                return
            }
            for obj in value {
                self.cars.append(Car(fromJson: JSON(obj)))
                
            }
            if let mini = self.filter(groupBy: CarList.mini) {
                self.sectionsData?[CarList.mini] = mini
            }
            if let bmw = self.filter(groupBy: CarList.bmw) {
                self.sectionsData?[CarList.bmw] = bmw
                
            }
            completion(error)
        }
    }
    
    
    func car(at index:Int) -> Car? {
        return cars[index]
    }
    
    func count() -> Int {
        return cars.count
    }
    
    func filter(groupBy group:String) -> [Car]? {
        return cars.filter { $0.group == group }
    }
    
    func makers() -> [CLLocationCoordinate2D] {
        var locations:[CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        for obj in self.cars {
            let position = CLLocationCoordinate2D(latitude: obj.latitude, longitude: obj.longitude)
            locations.append(position)
        }
        return locations
    }
    
    func cordinate(at index:IndexPath) -> CLLocationCoordinate2D? {
        
        switch index.section {
        case CarList.miniSectionIndex:
            
            if let miniArray = self.sectionsData?[CarList.mini] {
                return CLLocationCoordinate2D(latitude: miniArray[index.row].latitude, longitude: miniArray[index.row].longitude)
            }
            
            break
            
        case CarList.bmwSectionIndex:
            
            if let bmwArray = self.sectionsData?[CarList.bmw] {
                return CLLocationCoordinate2D(latitude: bmwArray[index.row].latitude, longitude: bmwArray[index.row].longitude)
            }
            
            break
        default:
            break
            
        }
        
        return nil
    }
    
    
}
