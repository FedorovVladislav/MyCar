//
//  MapViewController.swift
//  MyCar


import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate {
    
// MARK: -UIItem
    
    @IBOutlet weak var distanceRoad: UILabel!
    @IBOutlet weak var MKMapView: MKMapView!
    
    @IBAction func AddRoad(_ sender: UIButton) {
        addRoadOnMapCall()
    }
    @IBAction func AddAdress(_ sender: UIButton) {
        AlertWithTextFieldAnd2Button(titleAlert: "Add new point", messageAlert: "Write adress of new point", titleButton: "Add")
    }
    
// MARK: -Variable
    
    var  MapModel = mapModel()
    var alertTextField: UITextField?
    var distans : Double = 0 {
        didSet {
            distanceRoad.text = "\(distans) km"
        }
    }

 //override func viewDidLoad() {
  //    super.viewDidLoad()
//}
    
// MARK: -Function
    func addRoadOnMap(source: CLLocationCoordinate2D, destenation: CLLocationCoordinate2D){
        
        self.MKMapView.delegate = self
    
        let sourcePlacemark = MKPlacemark(coordinate:source)
        
        let destinationPlacemark = MKPlacemark(coordinate: destenation)

        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

    
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile

        
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler:  {
            (response, error) -> Void in

            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                print("Error: 2")
                return
            }

            let route = response.routes[0]
            self.distans = route.distance/1000
            print ("Distance:\(self.distans)\n")
            self.MKMapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.MKMapView.setRegion(MKCoordinateRegion(rect), animated: true)
            
        })
        
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
                    self.addAnotationOnMap(adress: tempText)
                }
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func addAnotationOnMap(adress: String ) {
        MapModel.adressToFind = adress
        
        MapModel.findAdress { MapPoint in
            if let tempMapPoint = MapPoint {
                let annotation = MKPointAnnotation()
                annotation.coordinate = tempMapPoint
                self.MKMapView.addAnnotation(annotation)
            } else {
                print("Return Nil")
            }
        }
    }
    func addRoadOnMapCall(){
        
        if MapModel.getCountAdress() >= 2 {
            for i in 0...(MapModel.getCountAdress() - 2)  {
                print (i)
                if let source = MapModel.getLastAdress(index: i),
                   let destenation = MapModel.getLastAdress(index: i+1){
                    addRoadOnMap( source: source, destenation: destenation)
                }
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor
                   overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
}
