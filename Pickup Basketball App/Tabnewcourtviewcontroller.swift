//
//  Tabnewcourtviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya M on 4/6/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
 
import UIKit
import MapKit
 
class Tabnewcourtviewcontroller: UIViewController, UISearchBarDelegate {
    
    var user24:User?

    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    var locCoord: CLLocationCoordinate2D?
    var annotation : MKPointAnnotation?
        
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        mapView.addGestureRecognizer(tapRecognizer)
        
        configureLocationServices()
 
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView) //gives the location object of where you are clicking on mapView
        locCoord = mapView.convert(location, toCoordinateFrom: mapView) //converts location object to coordinates
        
        annotation = MKPointAnnotation()
        annotation!.coordinate = locCoord!
        annotation!.title = "latitude:" + String(format: "%0.02f", annotation!.coordinate.latitude) + "& longitude:" + String(format: "%0.02f", annotation!.coordinate.longitude)
        annotation!.subtitle = "Loc of new bball court"
           
        mapView.addAnnotation(annotation!)
        
        performSegue(withIdentifier: "new_court_segue", sender: UITapGestureRecognizer())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        if segue.identifier == "new_court_segue"{
            super.prepare(for: segue, sender: sender)
            mapView.removeAnnotation(self.annotation!)
            zoomToLatestLocation(with: currentCoordinate!)
            let MainVC = segue.destination as! Newcourtviewcontroller
            MainVC.coordinates = locCoord
            
        }
        else if segue.identifier == "unwindToMapSegue" {
            super.prepare(for: segue, sender: sender)
            let vc = segue.destination as! Homeviewcontroller
            vc.annotation = self.annotation
            
        }
    }
    
    @IBAction func unwindToTab(segue: UIStoryboardSegue) {
        self.performSegue(withIdentifier: "unwindToMapSegue", sender: segue)
    }
            
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.view.isUserInteractionEnabled = false
            
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.style = UIActivityIndicatorView.Style.medium
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            
            self.view.addSubview(activityIndicator)
            
            searchBar.resignFirstResponder()
            dismiss(animated: true, completion: nil)
            
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = searchBar.text
            
            let activeSearch = MKLocalSearch(request: searchRequest)
            
            activeSearch.start {
                (response, error) in
                activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
                
                if (response == nil){
                    print("Error")
                }
                
                else {
                    
                    let latitude = response!.boundingRegion.center.latitude
                    let longitude = response!.boundingRegion.center.longitude
                    
                    let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    let region = MKCoordinateRegion(center: coordinate, span: span)
                    
                    self.mapView.setRegion(region, animated: true)
                    
                }
                
            }
        }
    func configureLocationServices(){
        locationManager.delegate = self
        
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
        
}
 
extension Tabnewcourtviewcontroller: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let latestLocation = locations.first else { return }
       
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
        }
        
        currentCoordinate = latestLocation.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        if status == .authorizedWhenInUse || status == .authorizedAlways {
            beginLocationUpdates(locationManager: manager)
        }
    }
}
 
extension Tabnewcourtviewcontroller: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        
        if annotation === mapView.userLocation{
            annotationView?.image = UIImage(named: "user")
        } else if (annotation.title) != nil{
            annotationView?.image = UIImage(named: "slimyBall")
        }
        
        annotationView?.canShowCallout = true //callout is triggered when we tap on the annotation
        
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
}

