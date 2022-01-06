//
//  ViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 20.10.2021.
//

import UIKit


class HomeViewController: UIViewController, changeStateCar {
   

    override func viewDidLoad() {
        super.viewDidLoad()
        stateCar.delegate = self
        getWheatherData()
        stateCar.getStateCar()
        
    }
    
    // MARK: -  delegate
    func stateCar(carData: [CarData]) {
        isStartEngien = (Int(carData[0].param))!.boolValue
        isLockCar = (Int(carData[1].param))!.boolValue
        isFanCar = (Int(carData[2].param))!.boolValue
        rangeFuelText = Int(carData[3].param)!
    }
    
    func startStopCar(isStartEngien: Bool) {
        self.isStartEngien = isStartEngien
    }
    
    func lockUnlockCar(isLockCar: Bool) {
        self.isLockCar = isLockCar
    }
    
    func onOffFan(isFanCar: Bool) {
        self.isFanCar = isFanCar
    }
    
    // MARK: - method
    private func getWheatherData(){
        NetworkManager.getWeatherData { wheatherOut, temperature in
            
            guard let temperature = temperature else {return }
            self.outsideTemp = temperature
        }
    }
    
    // MARK: -  Variable
    
    private var isStartEngien = false {
        didSet{
            DispatchQueue.main.sync {
                if isStartEngien {
                    
                    startEngien.backgroundColor =  .systemGreen
                    startEngien.setTitle("Start Eng", for: .normal)
                } else {
                    startEngien.backgroundColor = .lightGray
                    startEngien.setTitle("Stop Eng", for: .normal)
                }
            }
        }
    }
    
    private var isLockCar = false {
        didSet{
            DispatchQueue.main.sync{
                if isLockCar {
                    lockCar.backgroundColor =  .systemGreen
                    lockCar.setTitle("Locked", for: .normal)
                } else {
                    lockCar.backgroundColor = .lightGray
                    lockCar.setTitle("Unlocked", for: .normal)
                   
                }
            }
        }
    }
   
    private var isFanCar = false{
        didSet{
            DispatchQueue.main.sync{
                if isFanCar {
                    fanCar.backgroundColor =  .systemGreen
                    fanCar.setTitle("Start Fan", for: .normal)
                } else{
                    fanCar.backgroundColor = .lightGray
                    fanCar.setTitle("Stop Fan", for: .normal)
                }
            }
        }
    }
    
    private var stateCar = StateCar()
    
    private var outsideTemp = 0.0 {
        didSet{
            let roundedSpeed = Double(round(10 * outsideTemp)/10)
            DispatchQueue.main.async {
                self.OutsideTemperature.text = "Outside: \(roundedSpeed) C "
            }
        }
    }
    
    private var rangeFuelText: Int = 0 {
        didSet{
            DispatchQueue.main.async {
                self.rangeFuel.text = "Range: \(self.rangeFuelText) km"
            }
        }
    }
    
    // MARK: - Storyboard element
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
    
    @IBOutlet weak var rangeFuel: UILabel!

}


