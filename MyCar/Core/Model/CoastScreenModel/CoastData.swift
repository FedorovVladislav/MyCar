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
    init (){
        do { try getDataFromModel()
        } catch {
            print (error)
        }
    }
    
    // MARK: - Variable
    
    static let shared = CoastsData()
    private let phoneStorageManager = PhoneStorageManager()
    private var coasts : [Coast] = []
    private var distanceTrip : Double = 0
    private let fuelPrice : Double = 50
    private var pricePerKilometr : Int  {
        get {
            var distance = Set <Double> ()
            var prices : Double = 0
        
            for coast in coasts {
                distance.insert(coast.odometr)
                prices += coast.price
            }
           
            guard let maxDistance = distance.max(), let minDistance = distance.min() else { return 0 }
            
            let changeDistance = maxDistance - minDistance
        
            if changeDistance > 0 {
                return (Int((prices / changeDistance).rounded()))
            } else { return 0 }
        }
    }
    
    private var totalDistance : Int {
        get {
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
    
    func getPricePerKilometrs()-> Int {
        return self.pricePerKilometr
    }
    
    func getPriceTrip(distance: Double) ->Double {
        self.distanceTrip = distance
        return priceTrip
    }
    
    
    // MARK: - Сеттеры
    
    func addNewCoast(newCoast coast: Coast) throws {
        
        do {
            try phoneStorageManager.addItemToStorage(newCoast: coast)
            addCoast(newCoast: coast)
        } catch { throw error }
            
    }
    
    func changeExistCoast(at index : Int, newCoast: Coast) throws {
        do {
            try phoneStorageManager.changeItemInStorage(at: index, newCoast: newCoast)
            changeCurentCoast(at: index, newCoast: newCoast)
        } catch { throw error }
    }
    
    func deleteDromModel(at index: Int ) throws {
        do {
            try phoneStorageManager.deleteItemFromStorage(at:  index)
            removeCoast(at: index)
        } catch { throw error }
    }
    
    // MARK: - Работас массивом
    
    private func addCoast(newCoast: Coast){
        print("Add New Coast:\(newCoast.name) , \(newCoast.odometr), \(newCoast.price)")
        self.coasts.append(newCoast)
    }
    
    private func removeCoast(at index:Int) {
        self.coasts.remove(at: index)
    }
    
    private func changeCurentCoast(at index: Int, newCoast: Coast) {
        self.coasts[index] = newCoast
    }
    
    
    // MARK: - Работас с моделью
    
    private func getDataFromModel() throws {
  
        do {
            let coasts = try phoneStorageManager.getItemsFromStorage()
            
            self.coasts = coasts!
            
        } catch { throw error }
    }
}

