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
}


