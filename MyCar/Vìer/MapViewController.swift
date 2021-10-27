//
//  MapViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 27.10.2021.
//

import UIKit
import MapKit
class MapViewController: UIViewController {

   // override func viewDidLoad() {
    //    super.viewDidLoad()

        // Do any additional setup after loading the view.
   // }
    
    //title = " work2 "

    var adress: String = ""
    var alertTextField: UITextField?
    
    @IBAction func AddAdress(_ sender: UIButton) {
        AlertWithTextFieldAnd2Button(titleAlert: "Add new point", messageAlert: "Write adress of new point", titleButton: "Add")
    }
    @IBAction func AddPoint(_ sender: UIButton) {
        addNewPointOnMap (adress: self.adress)
    }
    @IBOutlet weak var MKMapView: MKMapView!
    

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
}
