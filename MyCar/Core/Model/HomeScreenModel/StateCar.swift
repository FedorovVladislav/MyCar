//
//  StateCar.swift
//  MyCar
//
//  Created by Елизавета Федорова on 03.01.2022.
//

import Foundation

struct StateCar {
    
    var carData: [CarData]
    
    init (carData:[CarData]) {
        self.carData = carData
    }

    func getStateEquipment (at equipment: DataCarEquipment) -> Int {
        switch equipment {
        case .getState:
            return 0
        case .setEngien:
            return Int(carData[0].param)!
        case .setLockDoor:
            return Int(carData[1].param)!
        case .setFanSystem:
            return Int(carData[2].param)!
        case .getFuilLevle:
            return Int(carData[3].param)!
        }
    }
    
    mutating func setValues(carData : [CarData]) {
        self.carData = carData
    }
}
