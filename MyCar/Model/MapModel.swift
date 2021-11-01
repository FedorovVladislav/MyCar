//
//  MapModel.swift
//  MyCar
//
//  Created by Елизавета Федорова on 31.10.2021.
//

import Foundation
import MapKit

class mapModel {
    
    var arrAdress = [CLLocationCoordinate2D]()
    func getLastAdress ()->CLLocationCoordinate2D  {
        if !self.arrAdress.isEmpty {
            print("return norm")
            return self.arrAdress[0]
        }else {
            print("return error ")
            return CLLocationCoordinate2D(latitude: 51, longitude: 51)
        }
        
    }
    
    func  findAdress(completion: @escaping (CLLocationCoordinate2D) -> Void) {
        let adress = "Moscow"
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = adress

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                // Handle the error.
                completion(CLLocationCoordinate2D(latitude: 50, longitude: 51))
                return
            }
            
            for item in response.mapItems {
                if let name = item.name,
                    let location = item.placemark.location {
                    print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                    completion (CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                    return
                }
            }
        }
    }
}
