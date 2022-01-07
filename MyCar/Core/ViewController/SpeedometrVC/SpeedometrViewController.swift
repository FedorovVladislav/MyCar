import MapKit
import CoreLocation

class SpeedometrViewController: UIViewController {
        // MARK: -Variable
    let locationManager = CLLocationManager()
    var lastLocation : CLLocation?
    var speedCurcleUIView: Speedometer!
    
        // MARK: -Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Speedometer
        speedCurcleUIView = Speedometer(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 2/3, height: self.view.frame.width * 2/4))
        view.addSubview(speedCurcleUIView)
        speedCurcleUIView.center = view.center

        startLocationManager()
    }
        // MARK: -CoreLocation
        
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

extension SpeedometrViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        guard  let newLocation = locations.last else  { return }
        self.speedCurcleUIView.currentSpeed = newLocation.speed 
            
        guard let previerLocation = self.lastLocation else {
            self.lastLocation = newLocation
            return
        }
        //let fit = newLocation.distance(from: previerLocation)
    }
}






    


