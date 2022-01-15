//
//  Coast.swift
//  MyCar
//
//  Created by Елизавета Федорова on 08.11.2021.
//

import Foundation

struct Coast {
    
    var name : String
    var odometr : Double
    var price : Double
    var typeCoast : TypeCoast?
    var userDescription : String?
    
}

enum TypeCoast: String, CaseIterable {
    
    case repair = "Repair"
    case tuning = "Tunning"
    case to = "Technik inspection"
    case paidRoad = "Paid Road"
    case insurance = "Insurance"
    
}
