//
//  MapModel.swift
//  MyCar
//
//  Created by Елизавета Федорова on 31.10.2021.
//

import Foundation
import MapKit

class mapModel {
    
    
    var adressToFind: String = ""
    var arrPointOnMap = [CLLocationCoordinate2D]()
    
    var source: CLLocationCoordinate2D?
    var destenation: CLLocationCoordinate2D?
    
    
    func getCountAdress()-> Int{
        return arrPointOnMap.count
    }
    
    func getLastAdress (index: Int)-> CLLocationCoordinate2D?  {
        if (index >= 0) && (index <= (arrPointOnMap.count - 1)) {
            return arrPointOnMap[index]
        } else { return nil }
        
    }
    
    func  findAdress(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = self.adressToFind

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                // Handle the error.
                completion(nil)
                return
            }
            if let name = response.mapItems[0].name,
               let location = response.mapItems[0].placemark.location {
                print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                    self.arrPointOnMap.append(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                    completion (CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                    return
                }
            }
        }
    
    
func findRoad (completion : @escaping (MKRoute?, Double?) -> Void ){
   
    guard let source = self.source else { return }
    guard let destenation = self.destenation else { return }

    let directionRequest = MKDirections.Request()
    directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate:source))
    directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: destenation))
    directionRequest.transportType = .automobile
    
    // Calculate the direction
    let directions = MKDirections(request: directionRequest)
    directions.calculate(completionHandler:  { (response, error) -> Void in
        guard let response = response else {
            if let error = error {
                print("Error: \(error)")
                completion(nil, nil)
            }
            print("Error: 2")
            completion(nil, nil)
            return
        }
        completion(response.routes[0], response.routes[0].distance)
        })
    }
}


