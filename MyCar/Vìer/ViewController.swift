//
//  ViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 20.10.2021.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //@IBOutlet weak var mapVier:MKMapView!
    
    var locationManager:CLLocationManager?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        

        view.backgroundColor = .gray
    }
   
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    print ("good")
                }
            }
        }
    }
    
    

    
    
    
    
 
/*
    @IBAction func  didTaputton(){
        let vc = UIViewController()
         
        vc.view.backgroundColor = .red
        
        navigationController?.pushViewController(vc, animated: true)
    }
    */
    
}


