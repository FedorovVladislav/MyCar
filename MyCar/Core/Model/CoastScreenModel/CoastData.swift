import Foundation


class CoastsData {
    init (){
        do {
            try getDataFromModel()
        } catch {
            print (error)
        }
    }
    
    // MARK: - Variable
    static let shared = CoastsData()
    // CoreData manager
    private let phoneStorageManager = PhoneStorageManager()
    
    private let fuelPrice: Double = 50
    private var coasts: [Coast] = []
    private var distanceTrip: Double = 0
    
    // Вычисляемые данные
    private var pricePerKilometr: Double  {
        var prices: Double = 0
        // Считаем сумму
        for coast in coasts {
            prices += coast.price
        }
    
        if totalDistance > 0 {
            return prices / Double(totalDistance)
        } else {
            return 0
        }
    }
    
    private var totalDistance: Int {
        var distance = Set <Double>()
            
        for coast in coasts {
            distance.insert(coast.odometr)
        }
            
        guard let maxDistance = distance.max(), let minDistance = distance.min() else { return 0 }
        
        let changeDistance = maxDistance - minDistance
        
        if changeDistance > 0 {
            return Int(changeDistance.rounded())
        } else {
            return 0
        }
    }
    private var priceTrip: Double {
        return self.distanceTrip * Double(self.pricePerKilometr) + self.distanceTrip/100*7*fuelPrice
    }
    
    // MARK: - Геттеры
    func getCountCoasts() -> Int {
        return self.coasts.count
    }
    
    func getTotalDistance()->Int {
        return self.totalDistance
    }
    
    func getCoast(at index: Int) -> Coast? {
        if index < getCountCoasts() {
            print("Return coast at index: \(index)")
            return coasts[index]
        } else {
            print("Invalid index: \(index)")
            return nil
        }
    }
    
    func getPricePerKilometrs() -> Double {
        return self.pricePerKilometr
    }
    
    func getPriceTrip(distance: Double) -> Double {
        self.distanceTrip = distance
        return priceTrip
    }
    
    private func getDataFromModel() throws {
        do {
            let coasts = try phoneStorageManager.getItemsFromStorage()
            self.coasts = coasts!
        } catch {
            throw error
        }
    }
    
    // MARK: - Сеттеры
    func addNewCoast(newCoast coast: Coast) throws {
        // сохраняем в память телефона
        do {
            try phoneStorageManager.addItemToStorage(newCoast: coast)
            self.coasts.append(coast)
        } catch {
            throw error
        }
    }
    // редактируем в памяти телефона
    func changeExistCoast(at index : Int, newCoast coast: Coast) throws {
        do {
            try phoneStorageManager.changeItemInStorage(at: index, newCoast: coast)
            self.coasts[index] = coast
        } catch {
            throw error
        }
    }
    // удаляем данные
    func deleteFromModel(at index: Int) throws {
        do {
            try phoneStorageManager.deleteItemFromStorage(at: index)
            self.coasts.remove(at: index)
        } catch {
            throw error
        }
    }
}

