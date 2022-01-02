//
//  ViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 20.10.2021.
//

import UIKit


class HomeViewController: UIViewController {
    
    
    @IBAction func lockUIButton(_ sender: Any) {
        
    }
    @IBAction func fanUIButton(_ sender: Any) {
        
    }
    @IBAction func startMotorUIButton(_ sender: Any) {
        //sendRequest()
        
    }
    
    @IBOutlet weak var OutsideTemperature: UILabel!
    
    var outsideTemp = 2.0 {
        didSet{
            let roundedSpeed = Double(round(10 * outsideTemp)/10)
            DispatchQueue.main.async {
                self.OutsideTemperature.text = "Outside: \(roundedSpeed) C "
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        NetworkManager.getWeatherData { wheatherOut, temperature in
            
            guard let temperature = temperature else {return }
            self.outsideTemp = temperature
        }
    }
    
        
        
        
    
}


