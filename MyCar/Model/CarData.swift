//
//  CarData.swift
//  MyCar
//
//  Created by Елизавета Федорова on 22.10.2021.
//

import Foundation

class Car{
    var Motor = false
    var heater = false
    var locker = false
    
    
    func openCloseCar(){
        
        if self.locker {
            print("LockCar")
            self.locker = true
            
        }else{
            print("UnlockCar")
            self.locker = false
        }
        
        
        
    }
    func startStopMotor(){
        
        if self.Motor {
            print("StartMotor")
            self.Motor = true
            
        }else{
            print("StopMotor")
            self.Motor = false
        }
        
    }
    func startStopHeater() {
        if self.heater {
            print("HeaterOn")
            self.locker = true
            
        }else{
            print("HeaterOff")
            self.heater = false
        }
        
    }
    
    
}
