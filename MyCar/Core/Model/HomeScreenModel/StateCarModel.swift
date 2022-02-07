import Foundation

protocol ChangeStateCarDelegate {
    func stateCar(carState: StateCar)
}

enum DataCarEquipment: Int {
    case getState
    case setEngien
    case setLockDoor
    case setFanSystem
    case getFuilLevle
}

class StateCarModel {
    
    // MARK: - Variable
    var delegate: ChangeStateCarDelegate?
    var stateCar: StateCar?
    var networkManager = NetworkManager()
    
    // MARK: - methods
    func setStateCar(set equipment: DataCarEquipment) {
        if let stateCar = stateCar {
            let value =  stateCar.getStateEquipment(at: equipment).boolValue
            
            networkManager.fetchCarState(id: equipment.rawValue, value: (!value).intValue) { carData, error  in
                self.stateCar!.setValues(carData: carData!)
                self.delegate?.stateCar(carState: self.stateCar!)
            }
        } else {
            networkManager.fetchCarState(id: 0, value: 0) { carData, error in
                guard let carData = carData else {
                    print (error?.localizedDescription)
                    return
                }
                let stateCar = StateCar(carData: carData)
                
                self.stateCar = stateCar
                self.delegate?.stateCar(carState: stateCar)
            }
        }
    }
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
