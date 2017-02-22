//
//  Car.swift
//  Cars
//
//  Created by Kamal Jaiswal on 09/02/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Car{
    
    var carImageUrl : String!
    var color : String!
    var fuelLevel : Float!
    var fuelType : String!
    var group : String!
    var id : String!
    var innerCleanliness : String!
    var latitude : Double!
    var licensePlate : String!
    var longitude : Double!
    var make : String!
    var modelIdentifier : String!
    var modelName : String!
    var name : String!
    var series : String!
    var transmission : String!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        carImageUrl = json["carImageUrl"].stringValue
        color = json["color"].stringValue
        fuelLevel = json["fuelLevel"].floatValue
        fuelType = json["fuelType"].stringValue
        group = json["group"].stringValue
        id = json["id"].stringValue
        innerCleanliness = json["innerCleanliness"].stringValue
        latitude = json["latitude"].doubleValue
        licensePlate = json["licensePlate"].stringValue
        longitude = json["longitude"].doubleValue
        make = json["make"].stringValue
        modelIdentifier = json["modelIdentifier"].stringValue
        modelName = json["modelName"].stringValue
        name = json["name"].stringValue
        series = json["series"].stringValue
        transmission = json["transmission"].stringValue
    }
    
    
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if carImageUrl != nil{
            dictionary["carImageUrl"] = carImageUrl
        }
        if color != nil{
            dictionary["color"] = color
        }
        if fuelLevel != nil{
            dictionary["fuelLevel"] = fuelLevel
        }
        if fuelType != nil{
            dictionary["fuelType"] = fuelType
        }
        if group != nil{
            dictionary["group"] = group
        }
        if id != nil{
            dictionary["id"] = id
        }
        if innerCleanliness != nil{
            dictionary["innerCleanliness"] = innerCleanliness
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if licensePlate != nil{
            dictionary["licensePlate"] = licensePlate
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if make != nil{
            dictionary["make"] = make
        }
        if modelIdentifier != nil{
            dictionary["modelIdentifier"] = modelIdentifier
        }
        if modelName != nil{
            dictionary["modelName"] = modelName
        }
        if name != nil{
            dictionary["name"] = name
        }
        if series != nil{
            dictionary["series"] = series
        }
        if transmission != nil{
            dictionary["transmission"] = transmission
        }
        return dictionary
    }
    
    
}
