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
    
    
    init(name: String , odometr: String, price: String){
        let coast = Coast(name: name, odometr: odometr, price: price)
        self.coasts.append(coast)
    }


    func getCountCoasts() -> Int {
        return self.coasts.count
    }
    func getCoast(at index: Int) -> Coast{
        return coasts[index]
    }
    func addCoast(newCoast: Coast){
        print (newCoast.name)
        print (newCoast.odometr)
        print (newCoast.price)
        self.coasts.append(newCoast)
        
    }
   
}


