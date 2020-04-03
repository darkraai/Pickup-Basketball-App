//
//  SecondViewController.swift
//  Pickup Basketball App
//
//  Created by Surya M on 3/22/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import MapKit

class Homeviewcontroller: UIViewController {
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    private var destinations: [MKPointAnnotation] = []
    private var currentRoute: MKRoute?

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Loaded sucessfully2")
        mapView.delegate = self
        configureLocationServices()

    }
    
    func configureLocationServices(){
        locationManager.delegate = self //set location manager delegate to view controller
        
        let status  = CLLocationManager.authorizationStatus()
        if status == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            beginLocationUpdates(locationManager: locationManager)
        }
        
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager){
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    private func addAnnotations(){
        let appleParkAnnotation = MKPointAnnotation()
        appleParkAnnotation.title = "Apple Park"
        appleParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.332072300, longitude: -122.011138100)
        
        let ortegaParkAnnotation = MKPointAnnotation()
        ortegaParkAnnotation.title = "Ortega Park"
        ortegaParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.342226, longitude: -122.025617)
        
        destinations.append(appleParkAnnotation)
        destinations.append(ortegaParkAnnotation)
        
        let annotations: [MKAnnotation] = [appleParkAnnotation, ortegaParkAnnotation]
        
        mapView.addAnnotations(annotations)
        
    }
    
    private func constructRoute(userLocation: CLLocationCoordinate2D){
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinations[0].coordinate))
        directionsRequest.requestsAlternateRoutes = true
        directionsRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate { [weak self] (directionsReponse, error) in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let response = directionsReponse, response.routes.count > 0{
                strongSelf.currentRoute = response.routes[0]
                
                strongSelf.mapView.addOverlay(response.routes[0].polyline)
                strongSelf.mapView.setVisibleMapRect(response.routes[0].polyline.boundingMapRect, animated: true)
            }
        }
    }
        

}

extension Homeviewcontroller: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Just got latest location and updated map...")
        
        guard let latestLocation = locations.first else { return }
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
            addAnnotations()
            constructRoute(userLocation: latestLocation.coordinate)
        }
        currentCoordinate = latestLocation.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed!")
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            beginLocationUpdates(locationManager: manager)
        }
    }
}

extension Homeviewcontroller: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let currentRoute = currentRoute else {
            return MKOverlayRenderer()
        }
        let polyLineRenderer = MKPolylineRenderer(polyline: currentRoute.polyline)
        polyLineRenderer.strokeColor = UIColor.blue
        polyLineRenderer.lineWidth = 5
        
        return polyLineRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        if let title = annotation.title, title == "Apple Park" {
            annotationView?.image = UIImage(named: "slimyBall")
        } else if let title = annotation.title, title == "Ortega Park" {
            annotationView?.image = UIImage(named: "bball1")
        } else if annotation === mapView.userLocation{ //if the annotation passed in to the function is an instance (has the identity of:) the user location, then we render the user image
            annotationView?.image = UIImage(named: "user")
        }
        
        annotationView?.canShowCallout = true //callout is triggered when we tap on the annotation
        
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("The annotation was selected: \(String(describing: view.annotation?.title))")
    }
    
}
