import UIKit
import CoreData
import MapKit

class ProfileViewController: UIViewController {
    
    var uiImaget = UIImageView()
    var setSpeedUISlider = UISlider()
    var rotation = UITextView()
    let speed = Speedometer(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    var currentSpeed : Double =  0 {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speed.center = view.center
        view.addSubview(speed)
        setUISlider()

    }
    
    
    func setUISlider(){
        
        setSpeedUISlider.frame = CGRect(x: 20, y: 700, width: 300, height: 70)

        setSpeedUISlider.minimumValue = 0
        setSpeedUISlider.maximumValue = 180

        setSpeedUISlider.addTarget(self, action: #selector(setRotation), for: .valueChanged)

        view.addSubview(setSpeedUISlider)

        
    }
    
    @objc func setRotation( sender: UISlider) {
        print("\(sender.value)")
        speed.currentSpeed = CGFloat( sender.value)
        
    }
}



