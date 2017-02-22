//
//  NetworkService.swift
//  Cars
//
//  Created by Kamal Jaiswal on 11/02/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation
import Alamofire



fileprivate let getCars = "http://www.codetalk.de/cars.json"

class NetworkService: NSObject {

    class func fetch(cars completion: @escaping ([[String:AnyObject]]?, Error?) -> ()) {
        Alamofire.request(URL(string:getCars)!, method: .get).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                print("Error while fetching remote contacts: \(response.result.error)")
                completion(nil, response.result.error)
                return
            }
            guard let value = response.result.value as? [[String:AnyObject]] else {
                print("Malformed data received from all contacts service")
                completion(nil, nil)
                return
            }
             completion(value, response.result.error)
        }
    }
    
}
