import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - кнопки
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MKMapView.delegate = self
    }

    @IBAction func AddPoint(_ sender: UIBarButtonItem) {
        AlertWithTextFieldAnd2Button(titleAlert: "Add new point", messageAlert: "Write adress of new point", titleButton: "Add")
    }
    
    @IBAction func testBUTTON(_ sender: UIButton) {
        print ("Print data: \(coastData.getCountCoasts())")
    }
    
    
// MARK: -Variable

    var  MapModel = mapModel()
    
    var coastData = CoastsData.shared
    
    var distans : Double = 0 {
        didSet {
            distanceRoad.text = "\(distans) km"
        }
    }
    
    var alertTextField: UITextField?
    
    @IBOutlet weak var distanceRoad: UILabel!
    
    @IBOutlet weak var MKMapView: MKMapView!
    
// MARK: -Function
    func addRoadOnMap(){
        
        self.MapModel.findRoad { route, distance, time  in
            if let tempRoute = route{
                self.distans = distance!/1000
                print ("Price Trip : \(self.coastData.getPriceTrip(distance: distance!/1000))P")
                print ("time \(time!/3600)")
                print ("Distance:\(self.distans)\n")
                self.MKMapView.addOverlay(tempRoute.polyline, level: .aboveRoads)
            
                let rect = tempRoute.polyline.boundingMapRect
                self.MKMapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
    }

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
