//
//  HomeScreen.swift
//  MyCar
//
//  Created by Елизавета Федорова on 04.11.2021.
//

import Foundation


class WheatherData {
    
    func getWeather(complition: @escaping (String?, Double?)-> Void) {
        
        let url = URL(string: "api.openweathermap.org/data/2.5/weather?id=498817&appid=33e5bc177aca3cceb5a1840f598f73b7")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print("Error:\(error)")
                complition(nil,nil)
                
                return
            }
            
            guard let data = data else { return}
        
            do {
                let timezone = try JSONDecoder().decode(Wheather.self, from: data)
                complition(timezone.weather![0].main!, (timezone.main!.temp! - 273.15))
            } catch{
                print( "Error decodable")
            }
        }.resume()
        
    }
    
}
