import UIKit
import CoreData
import MapKit



class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NetworkManager.getCarStateData{ carData in
//
//            for elementData in carData {
//                print ("id: \(elementData.id),param: \(elementData.param)\n")
//            }
//        }
    }
    
    @IBAction func setThree(_ sender: UIButton) {
        NetworkManager.setCarStateData(id: 1, value: 3)
    }
    @IBAction func setFive(_ sender: UIButton) {
        NetworkManager.setCarStateData(id: 1, value: 5)
    }
    @IBAction func getRequest(_ sender: UIButton) {
//        NetworkManager.getCarStateData {carData in
//
//            for elementData in carData {
//                print ("id: \(elementData.id),param: \(elementData.param)\n")
//            }
//        }
    }
}
