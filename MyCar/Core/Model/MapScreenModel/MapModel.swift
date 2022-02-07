//
//  MapModel.swift
//  MyCar
//
//  Created by Елизавета Федорова on 31.10.2021.
//

import Foundation
import MapKit

class MapModel {
    
    // MARK: - Variable
    var adressToFind: String = ""
   
    var source: CLLocationCoordinate2D?
    var destenation: CLLocationCoordinate2D?
    var mapRegion : MKCoordinateRegion? 
    
    func findAdress(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        guard let mapRegion = mapRegion else { return }

        let searchRequest = MKLocalSearch.Request()
        
        searchRequest.naturalLanguageQuery = self.adressToFind
        searchRequest.region = mapRegion

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            
            if let error = error { print("Error search:\(error)") }
            
            guard let response = response else { return }
            
            if let name = response.mapItems[0].name, let location = response.mapItems[0].placemark.location {
                print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                
                if self.source == nil {
                    self.source = (CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                } else {
                    self.destenation = (CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                }
                completion (CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                }
            }
        }
    
    func findRoad(completion: @escaping (MKRoute?, Double?, TimeInterval?) -> Void) {
   
    guard let source = self.source, let destenation = self.destenation else { return }

    let directionRequest = MKDirections.Request()
    directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
    directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: destenation))
    directionRequest.transportType = .automobile
    
    // Calculate the direction
    let directions = MKDirections(request: directionRequest)
    directions.calculate{ (response, error) -> Void in
        guard let response = response else {
            if let error = error { print("Error: \(error)") }
            return
        }
        self.source = nil
        self.destenation = nil
        completion(response.routes[0], response.routes[0].distance, response.routes[0].expectedTravelTime)
        }
    }
}
