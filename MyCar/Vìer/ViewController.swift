//
//  ViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 20.10.2021.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
   

    
    
    @IBOutlet  var mapVier:MKMapView!

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapVier.setRegion(region, animated: true)
        }
    }
 

    @IBAction func  didTaputton(){
        let vc = UIViewController()
         
        vc.view.backgroundColor = .red
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


