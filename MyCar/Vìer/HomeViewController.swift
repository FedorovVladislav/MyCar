//
//  ViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 20.10.2021.
//

import UIKit


class HomeViewController: UIViewController {
    
    var outsideTemp = 2.0{
        didSet{
            DispatchQueue.main.async {
                self.OutsideTemperature.text = "Outside temp: \(self.outsideTemp) C "
            }
        }
    }
    
    @IBOutlet weak var OutsideTemperature: UILabel!
    var  wheatherData = WheatherData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("Init HomeScreen")
        wheatherData.getWeather { wheatherOut, temperature in
            print(wheatherOut!)
            self.outsideTemp = temperature!
        }
    }
}


