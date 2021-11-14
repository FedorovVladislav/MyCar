//
//  CoastModel.swift
//  MyCar
//
//  Created by Елизавета Федорова on 09.11.2021.
//

import Foundation

class CoastsData {
    
    //massiv with coasts
    private var coasts : [Coast] = [Coast (name: "FirstTO", odometr: 15000 , price: 15000.0)]
    private var pricePerKilometr : Double  {
        get {
        var odometrs = Set <Double>()
        var prices : Double = 0
        
        for coast in coasts { odometrs.insert(coast.odometr) }
        for coast in coasts { prices = prices + coast.price }
        
        let distance = odometrs.max()! - odometrs.min()!
        
        if distance > 0 {
           return (prices / distance)
        } else { return 0 }
        }
    }
    func getPricePerKilometr()->Double{
        return self.pricePerKilometr
    }
    
    func getCountCoasts() -> Int {
        return self.coasts.count
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
    
    func getPricePerKilometrs()-> Double {
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
}


