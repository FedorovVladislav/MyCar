//
//  CoastModel.swift
//  MyCar
//
//  Created by Елизавета Федорова on 09.11.2021.
//

import Foundation
import UIKit
import CoreData

class CoastsData {
    // MARK: - Иницалзация
    init(){
        getDataFromModel()
    }
    
    // MARK: - Переменные
    static let shared = CoastsData()
    private let phoneStorageManager = PhoneStorageManager()
    private var coasts : [Coast] = []
    private var distanceTrip : Double = 0
    private var fuelPrice : Double = 50
    private var pricePerKilometr : Int  {
        get {
            var distance = Set <Double> ()
            var prices : Double = 0
        
            for coast in coasts { distance.insert(coast.odometr) }
            for coast in coasts { prices = prices + coast.price }
            
            guard let maxDistance = distance.max(), let minDistance = distance.min() else { return 0 }
            
            let changeDistance = maxDistance - minDistance
        
            if changeDistance > 0 {
                return (Int((prices / changeDistance).rounded()))
            } else { return 0 }
        }
    }
    
    private var totalDistance : Int {
        get{
            var distance = Set <Double>()
            for coast in coasts { distance.insert(coast.odometr) }
            
            guard let maxDistance = distance.max(), let minDistance = distance.min() else { return 0 }
            
            return Int((maxDistance - minDistance).rounded())
        }
    }
    private var priceTrip : Double {
        return self.distanceTrip * Double(self.pricePerKilometr) + self.distanceTrip/100*7*fuelPrice
    }
    
    
    
    // MARK: - Геттеры
    func getCountCoasts() -> Int {
        return self.coasts.count
    }
    
    func getTotalDistance()->Int{
        return  self.totalDistance
    }
    
    func getCoast(at index: Int) -> Coast? {
        if index <= getCountCoasts() - 1 {
            print("Return coast at index: \(index)")
            return coasts[index]
        } else {
            print("Invalid index: \(index)")
            return nil
        }
    }
    
    func getPricePerKilometrs()-> Int {
        return self.pricePerKilometr
    }
    
    func getPriceTrip(distance: Double) ->Double {
        self.distanceTrip = distance
        return priceTrip
    }
    
    
    // MARK: - Сеттеры
    
    func addNewCoast(newCoast coast: Coast) -> Bool {
        if phoneStorageManager.addItemToStorage(newCoast: coast){
            addCoast(newCoast: coast)
            return true
        } else {
            return false
        }
    }
    
    func changeExistCoast(at index : Int, newCoast: Coast) -> Bool {
        if phoneStorageManager.changeExistCoast(at: index, newCoast: newCoast) {
            changeCurentCoast(at: index, newCoast: newCoast)
            return true
        } else { return false }
    }
    
    func deleteDromModel(at index: Int ){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let  fetchRequest = NSFetchRequest <CoreCoasts> (entityName: "CoreCoasts")
        do{
            let results = try context.fetch(fetchRequest)
            
            if index <= results.count - 1 {
                print("Remove coast at index: \(index)")
                context.delete(results[index])
                do{
                    try context.save()
                    removeCoast(at: index)
                    
                }catch let error as NSError { print("Core error save :\(error.localizedDescription)") }
    
            } else { print("Invalid index: \(index)") }
            
        }catch let error as NSError { print("deleteDromModel Core error:\(error.localizedDescription)") }
    }
    
    // MARK: - Работас массивом
    
    private func addCoast(newCoast: Coast){
    print("Add New Coast:\(newCoast.name) , \(newCoast.odometr), \(newCoast.price)")
    self.coasts.append(newCoast)
    }
    
    private func removeCoast(at index:Int) {
        if index <= getCountCoasts() - 1 {
            print("Remove coast at index: \(index)")
            self.coasts.remove(at: index)
        } else { print("Invalid index: \(index)") }
    }
    
    private func changeCurentCoast(at index: Int, newCoast: Coast) {
        if index <= getCountCoasts() - 1 {
            self.coasts[index] = newCoast
        } else { print("Invalid index: \(index)") }
    }
    
    
    // MARK: - Работас с моделью
    
    private func getDataFromModel() {
  
    guard let coasts = phoneStorageManager.getDataFromModel() else { return }
    self.coasts = coasts
    }
}
private enum typeCoast: String {
    case repair = "Repair"
    case tuning = "Tuning"
    case to = "TO"
    case paidRoad = "Paid Road"
    case insurance = "Insurance"
}
