//
//  ViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 20.10.2021.
//

import UIKit


class HomeViewController: UIViewController, changeStateCar {
    
    func startStopCar(isStartEngien: Bool) {
        self.isStartEngien = isStartEngien
    }
    
    func lockUnlockCar(isLockCar: Bool) {
        self.isLockCar = isLockCar
    }
    
    func onOffFan(isFanCar: Bool) {
        self.isFanCar = isFanCar
    }
    
    var isStartEngien = false {
        didSet{
            DispatchQueue.main.sync{
                if isStartEngien {
                    startEngien.tintColor = .green
                } else {
                    startEngien.tintColor = .gray
                }
            }
        }
    }
    
    var isLockCar = false {
        didSet{
            DispatchQueue.main.sync{
                if isLockCar {
                    lockCar.tintColor = .green
                } else {
                    lockCar.tintColor = .gray
                }
            }
        }
    }
   
    var isFanCar = false{
        didSet{
            DispatchQueue.main.sync{
                if isFanCar {
                    fanCar.tintColor = .green
                } else{
                    fanCar.tintColor = .gray
                }
            }
        }
    }
    
    var stateCar = StateCar()
 
    @IBOutlet weak var startEngien: UIButton!
    @IBOutlet weak var fanCar: UIButton!
    @IBOutlet weak var lockCar: UIButton!
    
     
    
    @IBAction func lockUIButton(_ sender: Any) {
        stateCar.lockCar(mode: !isLockCar)
    }
    @IBAction func fanUIButton(_ sender: Any) {
        stateCar.fanCar(mode: !isFanCar)
    }
    @IBAction func startMotorUIButton(_ sender: Any) {
        stateCar.startEngienCar(mode: !isStartEngien)
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
        stateCar.delegate = self
        
        NetworkManager.getWeatherData { wheatherOut, temperature in
            
            guard let temperature = temperature else {return }
            self.outsideTemp = temperature
        }
    }
}


