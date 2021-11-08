//
//  HomeScreen.swift
//  MyCar
//
//  Created by Елизавета Федорова on 04.11.2021.
//

import Foundation


class WheatherData {
    
    func getWeather(complition: @escaping (String?, Double?)-> Void) {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Petersburg&appid=33e5bc177aca3cceb5a1840f598f73b7")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print("Error:\(error)")
                complition(nil,nil)
                
                return
            }
            guard let data = data else { return}
            print(String(data: data, encoding: .utf8))
            do {
                let timezone = try JSONDecoder().decode(wheather.self, from: data)
                complition(timezone.weather![0].main!, (timezone.main!.temp! - 273.15))
            } catch{
                print( "Error decodable")
            }
        }.resume()
        
    }
    
}
