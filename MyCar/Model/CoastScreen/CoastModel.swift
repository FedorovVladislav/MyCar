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
    private var coasts : [Coast] = []
    private var pricePerKilometr : Int  {
        get {
        var odometrs = Set <Double>()
        var prices : Double = 0
        
        for coast in coasts { odometrs.insert(coast.odometr) }
        for coast in coasts { prices = prices + coast.price }
        
        let distance = odometrs.max()! - odometrs.min()!
        
        if distance > 0 {
            return (Int((prices / distance).rounded()))
        } else { return 0 }
        }
    }
    private var totalDistance : Int {
        get {
            var distance = Set <Double>()
            for coast in coasts { distance.insert(coast.odometr) }
            return Int((distance.max()!-distance.min()!).rounded())
            }
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
    
    // MARK: - Сеттеры
    
    func addNewCoast(newCoast coast: Coast) {
        print ("addNewCoast")
        
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CoreCoasts", in: context) else {return}
        
        let taskOject = CoreCoasts (entity: entity, insertInto: context)
        
        taskOject.name = coast.name
        taskOject.price = coast.price
        taskOject.odometr = coast.odometr
        
        if let userDescription = coast.userDescription {
        taskOject.userDescription = userDescription
        } else { taskOject.userDescription = "" }
        
        do {
            try context.save()
            addCoast(newCoast: coast)
        }
        catch let error as NSError { print ("addNewCoast Core Error:\(error.localizedDescription)") }
    }
    
    func changeExistCoast(at index : Int, newCoast: Coast){
        print ("changeExistCoast at \(index)")
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        let fetcht = NSFetchRequest <CoreCoasts> (entityName: "CoreCoasts")
        
        do{
            let results = try context.fetch(fetcht)
            
            if index <= results.count - 1 {
                results[index].name = newCoast.name
                results[index].price = newCoast.price
                results[index].odometr = newCoast.odometr
            
                if let userDescription = newCoast.userDescription {
                    results[index].userDescription = userDescription
                } else { results[index].userDescription = "" }
            
                do{
                    try context.save()
                    changeCurentCoast(at: index, newCoast: newCoast)
                }catch let error as NSError { print("changeExistCoast Save Core error:\(error.localizedDescription)") }
            } else { print("Invalid index: \(index)") }
        }catch let error as NSError { print("changeExistCoast Core error:\(error.localizedDescription)") }
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
    
    private func  addCoast(newCoast: Coast){
    print("Add New Coast:\(newCoast.name) , \(newCoast.odometr), \(newCoast.price)")
    self.coasts.append(newCoast)
    }
    
    private func removeCoast(at index:Int) {
        if index <= getCountCoasts() - 1 {
            print("Remove coast at index: \(index)")
            self.coasts.remove(at: index)
        } else { print("Invalid index: \(index)") }
    }
    
    private  func changeCurentCoast(at index: Int, newCoast: Coast) {
        if index <= getCountCoasts() - 1 {
            self.coasts[index] = newCoast
        } else { print("Invalid index: \(index)") }
    }
    
    
    // MARK: - Работас с моделью
    
    private func getDataFromModel() {
        print ("getDataFromModel")
        
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest <CoreCoasts>(entityName: "CoreCoasts")

        do{
            let result  =  try context.fetch(fetchRequest)
            for res in result {
                print ("AddFromCoreToClass")
                self.coasts.append(Coast(name: res.name!, odometr: res.odometr, price: res.price, userDescription: res.userDescription))
            }
            
        }catch let error as NSError { print("getDataFromModel CoreData Error:\(error.localizedDescription)") }
    }
    
}
