//
//  MapViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 27.10.2021.
//

import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate {
   
    @IBOutlet weak var MKMapView: MKMapView!
    
   override func viewDidLoad() {
       super.viewDidLoad()
       
       self.MKMapView.delegate = self
       
       let sourcePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.752578 , longitude: 37.623104))
       let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.756776 , longitude: 37.594700))

       let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
       let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

       let sourceAnnotation = MKPointAnnotation()

       if let location = sourcePlacemark.location {
           sourceAnnotation.coordinate = location.coordinate
       }
       let destinationAnnotation = MKPointAnnotation()
       if let location = destinationPlacemark.location {
           destinationAnnotation.coordinate = location.coordinate
       }
       self.MKMapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
       
   let directionRequest = MKDirections.Request()
       directionRequest.source = sourceMapItem
       directionRequest.destination = destinationMapItem
       directionRequest.transportType = .automobile

       // Calculate the direction
       let directions = MKDirections(request: directionRequest)

       directions.calculate {
           (response, error) -> Void in

           guard let response = response else {
               if let error = error {
                   print("Error: \(error)")
               }
               print("Error: 2")
               return
           }

           let route = response.routes[0]
           self.MKMapView.addOverlay(route.polyline, level: .aboveRoads)
           let rect = route.polyline.boundingMapRect
           self.MKMapView.setRegion(MKCoordinateRegion(rect), animated: true)
       }
   }
    

   
    func mapView(_ mapView: MKMapView, rendererFor
                   overlay: MKOverlay) -> MKOverlayRenderer {

               let renderer = MKPolylineRenderer(overlay: overlay)

               renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)

               renderer.lineWidth = 5.0

               return renderer
           }
       
        
   

    var adress: String = ""
    var alertTextField: UITextField?
    
    @IBAction func AddRoad(_ sender: UIButton) {
        print("ButtonPrestd")
       
        
        
    }
    @IBAction func AddAdress(_ sender: UIButton) {
        AlertWithTextFieldAnd2Button(titleAlert: "Add new point", messageAlert: "Write adress of new point", titleButton: "Add")
    }
    @IBAction func AddPoint(_ sender: UIButton) {
        addNewPointOnMap (adress: self.adress)
    }

    

    func AlertWithTextFieldAnd2Button(titleAlert: String, messageAlert: String, titleButton: String){
        var alertTextField: UITextField?
        
        let alertView = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: UIAlertController.Style.alert)
        alertView.addTextField(configurationHandler: { textField -> Void in
            alertTextField = textField
        })
        alertView.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alertView.addAction(UIAlertAction(title: titleButton, style: UIAlertAction.Style.default, handler: { ACTION -> Void in
                if let tempText = alertTextField?.text {
                    self.adress  = tempText
                }
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
    
    func addNewPointOnMap(adress: String){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = adress

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                // Handle the error.
                print ("Error request")
                return
            }
            for item in response.mapItems {
                if let name = item.name,
                    let location = item.placemark.location {
                    print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                    var CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D
                    self.MKMapView.addAnnotation(annotation)
                    return
                    
                }
            }
        }
    }
    // MARK: - showRouteOnMap
    // MARK: - MKMapViewDelegate
   
}
