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
    
    var timeRoute : TimeInterval = 0 {
        didSet {
            let formate  = DateComponentsFormatter()
            formate.allowedUnits = [.hour, .minute]
            //let rounded = Double(round(10*timeRoute)/10)
            guard let time = formate.string(from:  self.timeRoute) else { return }
            timeRouteUILable.text = "Time: \(time)h"
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
        
        // delete annotation
        guard let annotationMap = annotationMap else { return }
        self.MKMapView.removeAnnotations(annotationMap)
        // delete route
        guard let route = route else { return }
        self.MKMapView.removeOverlay(route)
        // tabble route
        self.roadInformationUIStackView.isHidden = true
        
    }
    
    func addRoadOnMap(){

        self.MapModel.findRoad { route, distance, time  in
            if let tempRoute = route {

                self.distansRoute = distance!/1000
                self.coastRoute =  self.coastData.getPriceTrip(distance: distance!/1000)
                self.timeRoute = time!
                print("ComplitionHanlde")
               
                self.MKMapView.addOverlay(tempRoute.polyline, level: .aboveRoads)
                
                let padding: CGFloat = 8
                
                self.MKMapView.setVisibleMapRect(
                    self.MKMapView.visibleMapRect.union(
                    tempRoute.polyline.boundingMapRect),
                    edgePadding: UIEdgeInsets(top: 0, left: padding, bottom: padding,right: padding),
                animated: true
                )
                
                self.roadInformationUIStackView.isHidden = false
            }
        }
    }

    func addAnotationOnMap(adress: String ) {

        MapModel.adressToFind = adress

        MapModel.findAdress{ MapPoint in
            guard let tempMapPoint = MapPoint else { return }

            let annotation = MKPointAnnotation()
            annotation.coordinate = tempMapPoint

            self.MKMapView.addAnnotation(annotation)
            if  self.annotationMap == nil {
                self.annotationMap = [annotation]
            } else {
                self.annotationMap?.append(annotation)
            }
            
            self.MKMapView.setRegion(MKCoordinateRegion(center: MapPoint!, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)), animated: true)

            if self.MapModel.destenation != nil {
                self.addRoadOnMap()
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
            self.MapModel.mapRegion = region
    }
}

