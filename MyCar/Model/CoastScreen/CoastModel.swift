//
//  CoastModel.swift
//  MyCar
//
//  Created by Елизавета Федорова on 09.11.2021.
//

import Foundation

class CoastsData {
    
    //massiv with coasts
    private var coasts = [Coast]()
    private var pricePerKilometr : Double?
    

    
    
    init(name: String , odometr: Double, price: Double){
        let coast = Coast(name: name, odometr: odometr, price: price)
        self.coasts.append(coast)
        calProcePerKilometr()
    }

    
    func calProcePerKilometr(){
        
        var odometrs = Set <Double>()
        var prices : Double = 0
        
        for coast in coasts { odometrs.insert(coast.odometr) }
        for coast in coasts { prices = prices + coast.price }
        
        let distance = odometrs.max()! - odometrs.min()!
        
        if distance > 0{
            self.pricePerKilometr = (prices / distance)
            print ( "pricePerKilometr:\(self.pricePerKilometr)")
        } else{ self.pricePerKilometr = 0
            print ( "pricePerKilometr:\(self.pricePerKilometr)")
        }
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
        return self.pricePerKilometr!
    }
    
    func addCoast(newCoast: Coast){
        print (newCoast.name)
        print (newCoast.odometr)
        print (newCoast.price)
        self.coasts.append(newCoast)
        calProcePerKilometr()
        
    }
    
    func removeCoast(at index:Int) {
        if index <= getCountCoasts() - 1 {
            print("Remove coast at index: \(index)")
            self.coasts.remove(at: index)
            calProcePerKilometr()
        } else { print("Invalid index: \(index)") }
    }
}


