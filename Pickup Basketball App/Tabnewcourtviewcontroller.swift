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
    var annotation = MKPointAnnotation()
        
//    private var destinations: [MKPointAnnotation] = []
//    private var currentRoute: MKRoute?
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
//        print(user24!.username)

        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            
        annotation.coordinate = locCoord!
        annotation.title = "latitude:" + String(format: "%0.02f", annotation.coordinate.latitude) + " & longitude:" + String(format: "%0.02f", annotation.coordinate.longitude)
        annotation.subtitle = "Loc of new bball court"
           
    //  self.mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        performSegue(withIdentifier: "new_court_segue", sender: UITapGestureRecognizer())
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Newcourtviewcontroller") as! Newcourtviewcontroller
//        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        super.prepare(for: segue, sender: sender)
        let vc = segue.destination as! Newcourtviewcontroller
        vc.annotation = annotation
        mapView.removeAnnotation(self.annotation)
        zoomToLatestLocation(with: currentCoordinate!)
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
    //                let annotations = self.mapView.annotations
    //                self.mapView.removeAnnotation(annotations as! MKAnnotation)
                    
                    let latitude = response!.boundingRegion.center.latitude
                    let longitude = response!.boundingRegion.center.longitude
                    
    //                let annotation = MKPointAnnotation()
    //                annotation.title = searchBar.text
    //                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    //                self.mapView.addAnnotation(annotation)
                    
                    let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    let region = MKCoordinateRegion(center: coordinate, span: span)
                    
                    self.mapView.setRegion(region, animated: true)
                    
                }
                
            }
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
//            let appleParkAnnotation = MKPointAnnotation()
//            appleParkAnnotation.title = "Apple Park"
//            appleParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.332072300, longitude: -122.011138100)
//
//            let ortegaParkAnnotation = MKPointAnnotation()
//            ortegaParkAnnotation.title = "Ortega Park"
//            ortegaParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.342226, longitude: -122.025617)
//
    //        destinations.append(appleParkAnnotation)
    //        destinations.append(ortegaParkAnnotation)
            
//            let annotations: [MKAnnotation] = [appleParkAnnotation, ortegaParkAnnotation]
//
//            mapView.addAnnotations(annotations)
            
    }
    
    
//    private func constructRoute(userLocation: CLLocationCoordinate2D){
//        let directionsRequest = MKDirections.Request()
//        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
//        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinations[0].coordinate))
//        directionsRequest.requestsAlternateRoutes = true
//        directionsRequest.transportType = .automobile
//
//        let directions = MKDirections(request: directionsRequest)
//
//        directions.calculate { [weak self] (directionsReponse, error) in
//            guard let strongSelf = self else { return }
//
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let response = directionsReponse, response.routes.count > 0{
//                strongSelf.currentRoute = response.routes[0]
//
//                strongSelf.mapView.addOverlay(response.routes[0].polyline)
//                strongSelf.mapView.setVisibleMapRect(response.routes[0].polyline.boundingMapRect, animated: true)
//            }
//        }
//    }
 
}
 
extension Tabnewcourtviewcontroller: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let latestLocation = locations.first else { return }
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
            addAnnotations()
//            constructRoute(userLocation: latestLocation.coordinate)
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
 
extension Tabnewcourtviewcontroller: MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        guard let currentRoute = currentRoute else {
//            return MKOverlayRenderer()
//        }
//        let polyLineRenderer = MKPolylineRenderer(polyline: currentRoute.polyline)
//        polyLineRenderer.strokeColor = UIColor.blue
//        polyLineRenderer.lineWidth = 5
//
//        return polyLineRenderer
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        
        if annotation === mapView.userLocation{ //if the annotation passed in to the function is an instance (has the identity of:) the user location, then we render the user image
            annotationView?.image = UIImage(named: "user")
        } else if (annotation.title) != nil{
            annotationView?.image = UIImage(named: "slimyBall")
        }
        
        annotationView?.canShowCallout = true //callout is triggered when we tap on the annotation
        
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("The annotation was selected: \(String(describing: view.annotation?.title))")
    }
    
}

