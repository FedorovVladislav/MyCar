import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.roadInformationUIStackView.isHidden = true
        startLocationManager()
    }
    
    // MARK: - кнопки

    @IBAction func AddPoint(_ sender: UIBarButtonItem) {
        AlertWithTextFieldAnd2Button(titleAlert: "Add new point", messageAlert: "Write adress of new point", titleButton: "Add")
    }
    
    @IBAction func removeRote(_ sender: UIBarButtonItem) {
        removeRoute()
    }
   
    // MARK: - надписи
    
    @IBOutlet weak var distanceUILable: UILabel!
    
    @IBOutlet weak var timeRouteUILable: UILabel!
    
    @IBOutlet weak var coastRoadUILale: UILabel!
    
    @IBOutlet weak var roadInformationUIStackView: UIStackView!
    
    // MARK: -Variable
    let locationManager = CLLocationManager()
    
    var annotationMap : [MKAnnotation]?
    
    var route : MKOverlay?
    
    var MapModel = mapModel()
    
    var coastData = CoastsData.shared
    
    var distansRoute : Double = 0 {
        didSet {
             let rounded = Double(round(10*distansRoute)/10)
             distanceUILable.text = "Distance: \(rounded)km"
        }
    }
    
    var timeRoute : Double = 0 {
        didSet {
            let rounded = Double(round(10*timeRoute)/10)
             timeRouteUILable.text = "Time: \(rounded)h"
        }
    }
    
    var coastRoute : Double = 0 {
        didSet {
            let rounded = Double(round(10*coastRoute)/10)
            coastRoadUILale.text = "Coast: \(rounded)P"
        }
    }
    
    var alertTextField: UITextField?
    
    @IBOutlet weak var MKMapView: MKMapView!
    
// MARK: -Function
    
    func AlertWithTextFieldAnd2Button(titleAlert: String, messageAlert: String, titleButton: String){
        
        let alertView = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: UIAlertController.Style.alert)
        
        alertView.addTextField()
        alertView.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alertView.addAction(UIAlertAction(title: titleButton, style: UIAlertAction.Style.default, handler: { ACTION -> Void in
            guard  let tempText = alertView.textFields?.first?.text else { return }
            self.addAnotationOnMap(adress: tempText)
        }))
        
        self.present(alertView, animated: true, completion: nil)
    }
    
    func removeRoute(){
        self.roadInformationUIStackView.isHidden = true
        
        guard let annotationMap = annotationMap else { return }
        self.MKMapView.removeAnnotations(annotationMap)
        
        guard let route = route else { return }
        self.MKMapView.removeOverlay(route)
        
        
    }
    
    func addRoadOnMap(){
        
        self.MapModel.findRoad { route, distance, time  in
            if let tempRoute = route {
                
                self.distansRoute = distance!/1000
                self.coastRoute =  self.coastData.getPriceTrip(distance: distance!/1000)
                self.timeRoute = Double(time!/3600)

                
                self.MKMapView.addOverlay(tempRoute.polyline, level: .aboveRoads)
                self.route = tempRoute.polyline
                let rect = tempRoute.polyline.boundingMapRect
                self.MKMapView.setRegion(MKCoordinateRegion(rect), animated: true)
                self.roadInformationUIStackView.isHidden = false
            }
        }
    }

    func addAnotationOnMap(adress: String ) {
        
        MapModel.adressToFind = adress
        
        MapModel.findAdress { MapPoint in
            guard let tempMapPoint = MapPoint else { return }
                
            let annotation = MKPointAnnotation()
            annotation.coordinate = tempMapPoint
            
            self.MKMapView.addAnnotation(annotation)
            self.MKMapView.setRegion(MKCoordinateRegion(center: MapPoint!, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)), animated: true)
                
            if self.MapModel.destenation != nil {
                    self.addRoadOnMap()
            }else {
                //self.annotationMap![0] = annotation
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func startLocationManager(){
        self.MKMapView.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.pausesLocationUpdatesAutomatically  = false
            locationManager.startUpdatingLocation()
            self.MKMapView.showsUserLocation = true
        }
    }
    
   
}

extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard  let lastLocatin = locations.last else  { return }
        let region = MKCoordinateRegion.init(center: lastLocatin.coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000)
            MKMapView.setRegion(region, animated: true)
            self.MapModel.source  = lastLocatin.coordinate 
    }
}

