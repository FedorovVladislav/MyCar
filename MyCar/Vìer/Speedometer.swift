import UIKit


class Speedometer: UIView {
    // MARK: -Variable
    
    var currentSpeed : Double = 0 {
        didSet{
            if currentSpeed >=  10{
                if currentSpeed < 10 {
                    let roundedSpeed = Double(round(10 * currentSpeed)/10)
                    speedTittle.text = "\(roundedSpeed)"
                } else {
                    let roundedSpeed = Int(round(currentSpeed))
                    speedTittle.text = "\(roundedSpeed)"
                }
            }else {
                speedTittle.text = "0"
            }
            
            let levleCurcle: Double  = currentSpeed / 180
            progressCircle.strokeEnd = levleCurcle
        }
    }
    
    
    // MARK: -Private Variable
    
    private let progressCircle = CAShapeLayer()
    private let speedTittle = UILabel()
    private let speedUnit = UILabel()
    
   
    // MARK: -Constructor
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupSpeedCurcle()
        setupSpeedTittle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: -SetUp Function
    
    private func setupSpeedCurcle(){
        
        let centerPoint = CGPoint (x: self.bounds.width/2, y: self.bounds.width/2)
        let circleRadius : CGFloat = self.bounds.width/2
        let circlePath = UIBezierPath( arcCenter: centerPoint, radius: circleRadius, startAngle: 3 * CGFloat.pi / 4, endAngle: CGFloat.pi / 4, clockwise: true)
        
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.green.cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.borderColor = UIColor.black.cgColor
        progressCircle.borderWidth = 10
        progressCircle.lineWidth = 15
        
        self.layer.addSublayer(progressCircle)
    }
    
    private func setupSpeedTittle(){
    
        // Text
        speedTittle.text = "0"
        speedUnit.text = "KM/Ч"
        // Font and Size
        speedTittle.font = UIFont.systemFont(ofSize: 80, weight: .ultraLight)
        speedUnit.font = UIFont.systemFont(ofSize: 20, weight: .light)
        // Text Position
        speedTittle.textAlignment = .center
        speedUnit.textAlignment = .center
        // Color
        speedTittle.tintColor  = .gray
        speedUnit.tintColor = .gray
        
        // setting stackView
        let arrForStack =  [speedTittle, speedUnit]

        let speedStackView = UIStackView(arrangedSubviews: arrForStack)
        
        speedStackView.alignment = .fill
        speedStackView.axis = .vertical
        speedStackView.spacing = 0
        speedStackView.translatesAutoresizingMaskIntoConstraints = false
        speedStackView.distribution = .equalSpacing
    
        self.addSubview(speedStackView)
        // Anchor
        speedStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        speedStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}

