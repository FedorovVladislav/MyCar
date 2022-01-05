//
//  PhoneStorageManager.swift
//  MyCar
//
//  Created by Елизавета Федорова on 05.01.2022.
//

import Foundation
import CoreData
import UIKit

class PhoneStorageManager {
    
    
    func addItemToStorage(newCoast coast: Coast) -> Bool {
        print ("addNewCoast")
        
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CoreCoasts", in: context) else { return false }
    
        let taskOject = CoreCoasts (entity: entity, insertInto: context)
        
        taskOject.name = coast.name
        taskOject.price = coast.price
        taskOject.odometr = coast.odometr
        
        if let userDescription = coast.userDescription {
        taskOject.userDescription = userDescription
        } else { taskOject.userDescription = "" }
        
        do {
            try context.save()
            return true
        }
        catch let error as NSError {
            print ("addNewCoast Core Error:\(error.localizedDescription)")
            return false
        }
    }
    
    func changeExistCoast(at index : Int, newCoast: Coast) -> Bool{
       
        print ("changeExistCoast at \(index)")
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        let fetcht = NSFetchRequest <CoreCoasts> (entityName: "CoreCoasts")
        
        do {
            let results = try context.fetch(fetcht)
            
            if index <= results.count - 1 {
                results[index].name = newCoast.name
                results[index].price = newCoast.price
                results[index].odometr = newCoast.odometr
            
                if let userDescription = newCoast.userDescription {
                    results[index].userDescription = userDescription
                } else { results[index].userDescription = "" }
            
                do {
                    try context.save()
                    return true
                } catch let error as NSError {
                    print("changeExistCoast Save Core error:\(error.localizedDescription)")
                    return false
                }
            } else {
                print("Invalid index: \(index)")
                return false
            }
        }catch let error as NSError {
            print("changeExistCoast Core error:\(error.localizedDescription)")
            return false
        }
    }
    
    func deleteDromModel(at index: Int) -> Bool{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let  fetchRequest = NSFetchRequest <CoreCoasts> (entityName: "CoreCoasts")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if index <= results.count - 1 {
                print("Remove coast at index: \(index)")
                context.delete(results[index])
                do {
                    try context.save()
                    return true
                } catch let error as NSError {
                    print("Core error save :\(error.localizedDescription)")
                    return false
                }
            } else {
                print("Invalid index: \(index)")
                return false
            }
        } catch let error as NSError {
            print("deleteDromModel Core error:\(error.localizedDescription)")
            return false
        }
    }
    
    func getDataFromModel()-> [Coast]? {
        print ("getDataFromModel")
        
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest <CoreCoasts>(entityName: "CoreCoasts")

        do {
            let result  =  try context.fetch(fetchRequest)
            var coasts : [Coast] = []
            for res in result {
                coasts.append(Coast(name: res.name!, odometr: res.odometr, price: res.price, userDescription: res.userDescription))
            }
            return coasts
            
        } catch let error as NSError {
            print("getDataFromModel CoreData Error:\(error.localizedDescription)")
            return nil
        }
    }
}
