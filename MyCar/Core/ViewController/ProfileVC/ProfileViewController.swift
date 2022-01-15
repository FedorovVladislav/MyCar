import UIKit
import CoreData
import MapKit



class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sbsduf.setImage(UIImage(named: "folder.fill"), for: .normal)
        
      //  buttview.setState(tupeObjectName: "Motor", stateOnName: "Work", stateOffName: "Off", iconOnName: "", iconOffName: "")
//        NetworkManager.getCarStateData{ carData in
//
//            for elementData in carData {
//                print ("id: \(elementData.id),param: \(elementData.param)\n")
//            }
//        }
    }
    @IBOutlet weak var sbsduf: UIButton!
    
    @IBAction func buttonew(_ sender: UIButton) {
    }
    @IBOutlet weak var buttonView: ButtonSection!
    @IBOutlet weak var butt: UIButton!
    
    @IBOutlet weak var buttview: ButtonSection!
    
    @IBAction func button(_ sender: UIButton) {
    }
    @IBAction func setThree(_ sender: UIButton) {
        //NetworkManager.setCarStateData(id: 1, value: 3)
    }
    @IBAction func setFive(_ sender: UIButton) {
        //NetworkManager.setCarStateData(id: 1, value: 5)
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
