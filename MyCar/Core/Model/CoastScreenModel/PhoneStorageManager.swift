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

struct PhoneStorageManager {
    // MARK: - Method
    
    func addItemToStorage(newCoast coast: Coast) throws {
        
        let  context = getContex()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CoreCoasts", in: context) else { throw errorWorkWithCoreData.errorCoreDataEntity }
    
        var taskOject = CoreCoasts (entity: entity, insertInto: context)
        
            taskOject = setEntity(newCoast: coast, taskOject: taskOject)
        
        do {
            try context.save()
            
        } catch  { throw errorWorkWithCoreData.errorCoreDataSave }
    }
    
    func changeItemInStorage(at index : Int, newCoast: Coast) throws {
       
        print ("changeExistCoast at \(index)")
        
        let  context = getContex()
        
        let fetcht = NSFetchRequest <CoreCoasts> (entityName: "CoreCoasts")
        
        do {
            var results = try context.fetch(fetcht)
            
            guard  index <= results.count - 1 else { throw errorWorkWithCoreData.errorIndex }
            
            results[index] = setEntity(newCoast: newCoast, taskOject:   results[index])
            
            do {
                try context.save()
                
            } catch { throw errorWorkWithCoreData.errorCoreDataSave }
            
        } catch { throw errorWorkWithCoreData.errorCoreDataFetch }
    }
    
    func deleteItemFromStorage(at index: Int) throws {
        
        print("Remove coast at index: \(index)")
        
        let  context = getContex()
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
    
    func getItemsFromStorage() throws -> [Coast]? {
        
        print ("getDataFromModel")
        
        let  context = getContex()
        let fetchRequest = NSFetchRequest <CoreCoasts> (entityName: "CoreCoasts")

        do {
            let result  =  try context.fetch(fetchRequest)
            var coasts : [Coast] = []
            
            for res in result {
                coasts.append(Coast(name: res.name!, odometr: res.odometr, price: res.price, typeCoast:getTypeCoast(string: res.typeCoast), userDescription: res.userDescription))
            }
            return coasts
            
        } catch { throw errorWorkWithCoreData.errorCoreDataFetch}
    }
    
    private func getTypeCoast(string: String? ) -> TypeCoast {
        
        if let string = string, let typeCoast = TypeCoast.init(rawValue: string) {
            return typeCoast
        } else {
            return TypeCoast(rawValue: "Repair")!
        }
    }
    
    private func setEntity(newCoast coast: Coast, taskOject: CoreCoasts ) -> CoreCoasts {
            
            taskOject.name = coast.name
            taskOject.price = coast.price
            taskOject.odometr = coast.odometr
            taskOject.typeCoast = coast.typeCoast?.rawValue
            
            if let userDescription = coast.userDescription {
                taskOject.userDescription = userDescription
            } else {
                taskOject.userDescription = ""
            }
            return taskOject
        }
    
    private func getContex() -> NSManagedObjectContext{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}


