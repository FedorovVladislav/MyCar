//
//  ViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 20.10.2021.
//

import UIKit


class HomeViewController: UIViewController {
    
    
    @IBAction func lockUIButton(_ sender: Any) {
        
    }
    @IBAction func fanUIButton(_ sender: Any) {
        
    }
    @IBAction func startMotorUIButton(_ sender: Any) {
        sendRequest()
        
    }
    
    @IBOutlet weak var OutsideTemperature: UILabel!
    
    var outsideTemp = 2.0 {
        didSet{
            let roundedSpeed = Double(round(10 * outsideTemp)/10)
            DispatchQueue.main.async {
                self.OutsideTemperature.text = "Outside: \(roundedSpeed) C "
            }
            
        }
    }
    
    var  wheatherData = WheatherData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        wheatherData.getWeather { wheatherOut, temperature in
            
            guard let temperature = temperature else {return }
            self.outsideTemp = temperature
        }
    }
    
    func sendRequest(){
        
        
        
        
        print("request ")
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid

            let parameters = ["id": 13, "name": "jack"] as [String : Any]

            //create the url with URL
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")! //change the url

            //create the session object
            let session = URLSession.shared

            //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }

            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.addValue("application/json", forHTTPHeaderField: "Accept")

            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }

                guard let data = data else {
                    return
                }

                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        print(json)
                        // handle json...
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        
    }
    
}


