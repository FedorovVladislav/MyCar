//
//  CarViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 27.10.2021.
//
   
    import MapKit

    class CarViewController: UIViewController, MKMapViewDelegate {

        
        @IBOutlet weak var mapView: MKMapView!
        //@IBOutlet weak var mapView: MKMapView!
      override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.
        mapView.delegate = self
        
        // 2.
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
        
        // 3.
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Times Square"
        
        if let location = sourcePlacemark.location {
          sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Empire State Building"
        
        if let location = destinationPlacemark.location {
          destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7.
        
          let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8
         
          directions.calculate(completionHandler:{
          (response, error) -> Void in
          
          guard let response = response else {
            if let error = error {
              print("Error: \(error)")
            }
            
            return
          }
          
          let route = response.routes[0]
          self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
          
          let rect = route.polyline.boundingMapRect
          self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        })
      }

      override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
      }
      
        func mapView(_ mapView: MKMapView, rendererFor
                     overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
          renderer.strokeColor = .red
        renderer.lineWidth = 4.0
        
        return renderer
      }

    }


    


