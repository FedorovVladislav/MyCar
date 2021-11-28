import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MKMapView.delegate = self
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
    
    // MARK: -Variable
    
    var annotationMap : [MKAnnotation]?
    
    var route : MKOverlay?
    
    var MapModel = mapModel()
    
    var coastData = CoastsData.shared
    
    var distansRoute : Double = 0 {
        didSet {
            distanceUILable.text = "Distance: \(distansRoute)km"
        }
    }
    
    var timeRoute : Double = 0 {
        didSet {
            timeRouteUILable.text = "Time: \(timeRoute)h"
        }
    }
    
    var coastRoute : Double = 0 {
        didSet {
            coastRoadUILale.text = "Coast: \(coastRoute)P"
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
            }
        }
    }

    func addAnotationOnMap(adress: String ) {
        
        MapModel.adressToFind = adress
        
        MapModel.findAdress { MapPoint in
            guard let tempMapPoint = MapPoint else { return }
                
            let annotation = MKPointAnnotation()
            annotation.coordinate = tempMapPoint
            self.annotationMap?.append(annotation)
            self.MKMapView.addAnnotation(annotation)
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
    
}
