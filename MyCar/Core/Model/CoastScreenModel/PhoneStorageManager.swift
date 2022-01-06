//
//  PhoneStorageManager.swift
//  MyCar
//
//  Created by Елизавета Федорова on 05.01.2022.
//

import Foundation
import CoreData
import UIKit

enum errorWorkWithCoreData : Error {
    case errorCoreDataEntity
    case errorCoreDataSave
    case errorCoreDataFetch
    case errorIndex
    case error
}

class PhoneStorageManager {
    
    
    func addItemToStorage(newCoast coast: Coast) throws {
        
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CoreCoasts", in: context) else { throw errorWorkWithCoreData.errorCoreDataEntity }
    
        let taskOject = CoreCoasts (entity: entity, insertInto: context)
        
        taskOject.name = coast.name
        taskOject.price = coast.price
        taskOject.odometr = coast.odometr
        
        if let userDescription = coast.userDescription {
            taskOject.userDescription = userDescription
        } else { taskOject.userDescription = "" }
        
        do {
            try context.save()
            
        } catch let error as NSError {
            print ("addNewCoast Core Error:\(error.localizedDescription)")
            throw errorWorkWithCoreData.errorCoreDataSave
        }
    }
    
    func changeExistCoast(at index : Int, newCoast: Coast) throws {
       
        print ("changeExistCoast at \(index)")
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        let fetcht = NSFetchRequest <CoreCoasts> (entityName: "CoreCoasts")
        
        do {
            let results = try context.fetch(fetcht)
            
            guard  index <= results.count - 1 else { throw errorWorkWithCoreData.errorIndex }
            
            results[index].name = newCoast.name
            results[index].price = newCoast.price
            results[index].odometr = newCoast.odometr
        
            if let userDescription = newCoast.userDescription {
                results[index].userDescription = userDescription
            } else { results[index].userDescription = "" }
        
            do {
                try context.save()
            } catch { throw errorWorkWithCoreData.errorCoreDataSave }
            
        } catch { throw errorWorkWithCoreData.errorCoreDataFetch }
    }
    
    func deleteDromModel(at index: Int) throws {
        print("Remove coast at index: \(index)")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let  fetchRequest = NSFetchRequest <CoreCoasts> (entityName: "CoreCoasts")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            guard index < results.count else { throw errorWorkWithCoreData.errorIndex}
            
            context.delete(results[index])
            
            do {
                try context.save()
            } catch { throw errorWorkWithCoreData.errorCoreDataSave }
        } catch { throw errorWorkWithCoreData.errorCoreDataFetch }
        
    }
    
    func getDataFromModel() throws -> [Coast]? {
        
        print ("getDataFromModel")
        
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest <CoreCoasts> (entityName: "CoreCoasts")

        do {
            let result  =  try context.fetch(fetchRequest)
            var coasts : [Coast] = []
            
            for res in result {
                coasts.append(Coast(name: res.name!, odometr: res.odometr, price: res.price, userDescription: res.userDescription))
            }
            return coasts
            
        } catch { throw errorWorkWithCoreData.errorCoreDataFetch}
    }
}


