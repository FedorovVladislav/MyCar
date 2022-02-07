import UIKit


class Speedometer: UIView {
    
    // MARK: - Variable
    var currentSpeed : Double = 0 {
        didSet {
            if currentSpeed > 10 {
                speedTittle.text = "\(currentSpeed.rounded0_X)"

            } else if currentSpeed > 0 {
                let roundedSpeed = Int(round(currentSpeed))
                speedTittle.text = "\(roundedSpeed)"
            
            } else {
                speedTittle.text = "0"
            }
            
            let levleCurcle: Double  = currentSpeed / 180
            progressCircle.strokeEnd = levleCurcle
        }
    }
    
    // MARK: - Private Variable
    private let progressCircle = CAShapeLayer()
    private let speedTittle = UILabel()
    private let speedUnit = UILabel()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSpeedCurcle()
        setupSpeedTittle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSpeedCurcle() {
        
        let centerPoint = CGPoint (x: self.bounds.width/2, y: self.bounds.width/2)
        let circleRadius : CGFloat = self.bounds.width/2
        let circleProgressPath = UIBezierPath( arcCenter: centerPoint, radius: circleRadius, startAngle: 3 * CGFloat.pi / 4, endAngle: CGFloat.pi / 4, clockwise: true)
        
        progressCircle.path = circleProgressPath.cgPath
        progressCircle.strokeColor = UIColor.green.cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 4
        progressCircle.strokeEnd = 0
        
        let borderCircle = CAShapeLayer()
        let circleBorderPath = UIBezierPath( arcCenter: centerPoint, radius: circleRadius + progressCircle.lineWidth / 2, startAngle: 3 * CGFloat.pi / 4, endAngle: CGFloat.pi / 4, clockwise: true)
        
        
        borderCircle.path = circleBorderPath.cgPath
        borderCircle.strokeColor = UIColor.black.cgColor
        borderCircle.fillColor = UIColor.clear.cgColor
        borderCircle.lineWidth = 0.5
        
        self.layer.addSublayer(borderCircle)
        self.layer.addSublayer(progressCircle)
    }
       
    private func setupSpeedTittle() {
    
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

