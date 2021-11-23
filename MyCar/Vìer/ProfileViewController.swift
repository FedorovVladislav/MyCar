//
//  ProfileViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 28.10.2021.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    var massiv = [CoreCoasts] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func das(_ sender: UIButton) {
        print("workAdd")
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CoreCoasts", in: context) else {return}
        
        let taskOject = CoreCoasts (entity: entity, insertInto: context)
        
        taskOject.name = "TO2"
        taskOject.price = 20
        taskOject.odometr = 15000
        taskOject.userDescription = ""
        
        do {
            try context.save()
        }
        catch let error as NSError{
            print ("Core error2:\(error.localizedDescription)")
        }
    }
    @IBAction func deleteLast(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let  fetchRequest = NSFetchRequest <CoreCoasts> (entityName: "CoreCoasts")
        do{
            let results = try context.fetch(fetchRequest)
            let last = results.count - 1
            context.delete(results[last])
            do{
                try context.save()
                print ("Delete goof")
            }catch let error as NSError {
                print("Core error save :\(error.localizedDescription)")
             }
            
        }catch let error as NSError {
                print("Core error delete :\(error.localizedDescription)")
             }
        }
    
    
    @IBAction func printelement(_ sender: UIButton) {
        print ("printWork")
        
         let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest <CoreCoasts>(entityName: "CoreCoasts")

        do{
            let result  =  try context.fetch(fetchRequest)
            for res in result {
                
                print ("Name:\(res.name)")
                print ("odometr:\(res.odometr)")
                print ("price:\(res.price)")
                print ("userDescription:\(res.userDescription)")
    
            }
        }catch let error as NSError {
           print("Core error1:\(error.localizedDescription)")
        }
         
        
    }
}




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


