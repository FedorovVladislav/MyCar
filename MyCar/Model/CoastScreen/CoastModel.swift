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
    
    init(){
        getDataFromModel()
    }
    
    //massiv with coasts
    private var coasts : [Coast] = [Coast (name: "FirstTO", odometr: 15000 , price: 15000.0)]
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
    
    func addCoast(newCoast: Coast){
        print("Add New Coast:\(newCoast.name) , \(newCoast.odometr), \(newCoast.price)")
        self.coasts.append(newCoast)
    }
    
    func removeCoast(at index:Int) {
        if index <= getCountCoasts() - 1 {
            print("Remove coast at index: \(index)")
            self.coasts.remove(at: index)
        } else { print("Invalid index: \(index)") }
    }
    func changeCurentCoast(at index: Int, newCoast: Coast) {
        if index <= getCountCoasts() - 1 {
            self.coasts[index] = newCoast
        } else { print("Invalid index: \(index)") }
    }
    
    
    func addNewCoast(newCoast coast: Coast) {
       
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
        }
        catch let error as NSError{
            print ("Core error2:\(error.localizedDescription)")
        }
    }
    
    func getDataFromModel() {
        print ("printWork")
        
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest <CoreCoasts>(entityName: "CoreCoasts")

        do{
            let result  =  try context.fetch(fetchRequest)
            for res in result {
                self.coasts.append(Coast(name: res.name!, odometr: res.odometr, price: res.price, userDescription: res.userDescription))
            }
        }catch let error as NSError {
           print("Core error1:\(error.localizedDescription)")
        }
    }
}


