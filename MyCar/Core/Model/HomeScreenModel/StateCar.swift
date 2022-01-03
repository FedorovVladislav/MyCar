//
//  StateCar.swift
//  MyCar
//
//  Created by Елизавета Федорова on 03.01.2022.
//

import Foundation


class StateCar {
    
    var delegate: changeStateCar?
   
    func startEngienCar(mode : Bool){

        NetworkManager.CarStateData(id: 1, value: mode.intValue) { carData in
            self.delegate?.startStopCar(isStartEngien: (Int(carData[0].param))!.boolValue)
        }
    }
    
    func lockCar(mode : Bool){
       
        NetworkManager.CarStateData(id: 2, value: mode.intValue){ carData in
            self.delegate?.lockUnlockCar(isLockCar: (Int(carData[1].param))!.boolValue)
        }
    }
    
    func fanCar(mode : Bool){
        NetworkManager.CarStateData(id: 3, value: mode.intValue) { carData in
            self.delegate?.onOffFan(isFanCar: (Int(carData[2].param))!.boolValue)
        }
    }
}

protocol changeStateCar {
    func startStopCar(isStartEngien: Bool)
    func lockUnlockCar(isLockCar:Bool)
    func onOffFan(isFanCar:Bool)
}
extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}
extension Int {
    var boolValue: Bool {
        return self != 0
    }
}
