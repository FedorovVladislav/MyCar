    import MapKit
    import CoreLocation

    class CarViewController: UIViewController,MKMapViewDelegate {
        
        private let speedView : UIView = {
            let myView = UIView()
            myView.translatesAutoresizingMaskIntoConstraints =  false
            myView.backgroundColor = .black
            return myView
        }()
        
        let locationManager = CLLocationManager()
        var lastLocation : CLLocation?
        var totalDistance : Double = 0 {
            didSet{
                let rounded = round(1000*totalDistance/1000)
                distanceLable.text = "distance: \(rounded)"
            }
        }
        var speed: Double = 0 {
            didSet{
                speedUiLable.text = "speed: \(speed)"
            }
        }
        var slider : Float = 0.0 {
            didSet{
                speedUiLable.transform = speedUiLable.transform.rotated(by: .pi/2)
            }
        }
        
        
        @IBAction func cangeVaile(_ sender: Any) {
            self.slider = changeValue.value
            
        }
         var uiImaget = UIImageView()
        @IBOutlet weak var changeValue: UISlider!
        @IBOutlet weak var speedUiLable: UILabel!
        @IBOutlet weak var distanceLable: UILabel!
           
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
//            guard  let myImage = UIImage(named: "arrow-right-310628__480") else {return}
//        
//            startLocationManager()
//            view.addSubview(speedView)
//            
//            
//            uiImaget.contentMode = .scaleAspectFit
//            uiImaget.image = myImage
//            speedView.addSubview(uiImaget)
//            addConstrains()
        }
        func addConstrains(){
            var arrConstraints = [NSLayoutConstraint] ()
            
            arrConstraints.append(speedView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
            arrConstraints.append(speedView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor))
            arrConstraints.append(speedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
            arrConstraints.append(speedView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
            arrConstraints.append(uiImaget.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
            arrConstraints.append(uiImaget.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: 10))
            arrConstraints.append(uiImaget.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
           arrConstraints.append(uiImaget.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10))


            NSLayoutConstraint.activate(arrConstraints)
            
        }
        func startLocationManager(){
            locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.pausesLocationUpdatesAutomatically  = false
                locationManager.startUpdatingLocation()
            }
        }
    }

    extension CarViewController : CLLocationManagerDelegate {
        

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard  let newLocation = locations.last else  { return }
            self.speed =  newLocation.speed
            guard let previerLocation = self.lastLocation else {
                self.lastLocation = newLocation
                return
            }
            
            let fit = newLocation.distance(from: previerLocation)
            totalDistance += fit
        }
    }






    


