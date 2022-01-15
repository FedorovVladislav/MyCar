//
//  NetworkManager.swift
//  MyCar
//
//  Created by Елизавета Федорова on 02.01.2022.
//

import UIKit

class NetworkManager {
    
    
    static func getWeatherData(complition: @escaping (String?, Double?)-> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=498817&appid=33e5bc177aca3cceb5a1840f598f73b7")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print("Error:\(error)")
                complition(nil,nil)
                return
            }
            
            guard let data = data else { return}
            //print(String(data: data, encoding: .utf8))
            do {
                let timezone = try JSONDecoder().decode(Wheather.self, from: data)
                complition(timezone.weather![0].main!, (timezone.main!.temp! - 273.15))
            } catch{
                print( "Error decodable")
            }
        }.resume()
    }
    
    static func CarStateData(id:Int, value: Int, complition: @escaping ([CarData]) -> Void) {
        
        var urlString: String
        
        if id > 0 {
            urlString = "http://q95114zj.bget.ru/defpass.php?m=changeInt&id=\(id)&param=\(value)"
            print(urlString)
            
        } else { urlString = "http://q95114zj.bget.ru/defpass.php?m=changeInt" }
        
        guard let url = URL(string: urlString) else { return }
        
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Safari/605.1.15"
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, responce, error in
        
            
        guard let data = data  else { print("Error data"); return }
            
        let stringData = String(data: data, encoding: .utf8)
        print(stringData!)
            
        //Parce Data
        do{
            let carData = try JSONDecoder().decode([CarData].self, from: data)
            complition(carData)
            
        } catch { print( "Error decodable") }
            
        }.resume()
    }
    
}


