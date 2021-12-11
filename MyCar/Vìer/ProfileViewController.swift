import UIKit
import CoreData
import MapKit

class ProfileViewController: UIViewController {
    
    
    
    var uiImaget = UIImageView()
    var startutton = UIButton()
    var endButton = UIButton()
    var setSpeedUISlider = UISlider()
    var rotation = UITextView()
    
    //let circle = UIView()
    
    //let progressCircle = CAShapeLayer()
    
    
    let speed = speedUiview(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speed.center = view.center
        view.addSubview(speed)
        setUISlider()

    }
    
    
    func setUISlider(){
        
        setSpeedUISlider.frame = CGRect(x: 20, y: 700, width: 200, height: 70)

        setSpeedUISlider.minimumValue = 0
        setSpeedUISlider.maximumValue = .pi

        setSpeedUISlider.addTarget(self, action: #selector(setRotation), for: .valueChanged)

        view.addSubview(setSpeedUISlider)

        
    }
    
    @objc func setRotation( sender: UISlider) {
  
        speed.progressCircle.strokeEnd = CGFloat( sender.value)
        
    }
}
    class speedUiview: UIView {
        
        let progressCircle = CAShapeLayer()
        let speedTittle = UILabel()
        let speedUnit = UILabel()

        override init(frame: CGRect){
            super.init(frame: frame)
            setupSpeedCurcle()
            setupSpeedTittle()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupSpeedCurcle(){
            
        let centerPoint = CGPoint (x: self.bounds.width/2, y: self.bounds.width/2)
        let circleRadius : CGFloat = self.bounds.width/2
        let circlePath = UIBezierPath( arcCenter: centerPoint, radius: circleRadius, startAngle: 3 * CGFloat.pi / 4, endAngle: CGFloat.pi / 4, clockwise: true)
            
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.green.cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 6
            
        self.layer.addSublayer(progressCircle)

        }
        
        func setupSpeedTittle(){
            
            speedTittle.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            speedUnit.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            
            speedTittle.text = "0"
            speedUnit.text = "KM"
            
            speedTittle.font.
            speedUnit.text = "KM"
            
            
            speedTittle.textAlignment = .center
            speedUnit.textAlignment = .center
            
            speedTittle.tintColor  = .black
            speedUnit.tintColor = .black
            
            
            let arrForStack =  [speedTittle, speedUnit]
            // setting stackView
            
            let speedStackView = UIStackView(arrangedSubviews: arrForStack)
            
            speedStackView.alignment = .fill
            speedStackView.axis = .vertical
            speedStackView.spacing = 5
            speedStackView.translatesAutoresizingMaskIntoConstraints = false
            speedStackView.distribution = .equalSpacing
           
            self.addSubview(speedStackView)
            
            speedStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            speedStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
    
    


