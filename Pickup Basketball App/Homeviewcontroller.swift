 
//
//  HomeViewController.swift
//  Pickup Basketball App
//
//  Created by Surya M on 3/22/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
 
import UIKit
import MapKit
import FirebaseDatabase

 
class Homeviewcontroller: UIViewController, UISearchBarDelegate {
    
    var ref:DatabaseReference?
    
    var ref2:DatabaseReference?
        
    var user24:User?
    
    public var chosencourt:Court?
        
    var clickedannotation:MKAnnotation?
    
    var currentCoordinate: CLLocationCoordinate2D?
    
    var annotation: MKPointAnnotation?
    
    let locationManager = CLLocationManager()
            
    


 
    @IBOutlet weak var mapView: MKMapView!
    
    
    //configures location and map stuff
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        configureLocationServices()
 
    }
    //courts are loaded from datapoints in the database to annotations on the map
    override func viewWillAppear(_ animated: Bool) {
        loadcourts()

    }
    
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
        if segue.source is Tabnewcourtviewcontroller{
            zoomToLatestLocation(with: annotation!.coordinate)
            mapView.addAnnotation(annotation!)
            presentAlert()
        }
    }
    
    //alert when new court is added
    private func presentAlert(){
        let alertController = UIAlertController(title: "Court added!", message: "The court requested has successfuly been added.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //configures search button
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    //handles what happens when something is entered in search
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
    
    func loadcourts(){
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        ref = Database.database().reference().child("Parks")
        
        
        ref?.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0{
                 for courts in snapshot.children.allObjects as![DataSnapshot]{
                    let courtobject = courts.value as? [String:AnyObject]
                    let parkname = courtobject?["parkname"]
                    let lat = courtobject?["coordinateslat"]
                    let long = courtobject?["coordinateslong"]
                let annotation = MKPointAnnotation()
                    annotation.title = (parkname! as! String)
                    annotation.coordinate = CLLocationCoordinate2DMake(lat as! CLLocationDegrees,long as! CLLocationDegrees)
                    
                    self.mapView.addAnnotation(annotation)

                }
            }
            
        })

    }
    
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {}

    
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
 
extension Homeviewcontroller: CLLocationManagerDelegate {
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
 //extension designed to handle mapview stuff
extension Homeviewcontroller: MKMapViewDelegate {
    
    
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
    //looks for the clicked court. Once it's found, the home to game menu segue is executed
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        ref2 = Database.database().reference().child("Parks")
        ref2?.observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
         if snapshot.childrenCount > 0{
             for courts in snapshot.children.allObjects as![DataSnapshot]{
                 let courtobject = courts.value as? [String:AnyObject]
                 let parkname = courtobject?["parkname"]
                 let numcourts = courtobject?["numcourts"]
                 let address = courtobject?["Address"]
                 let lat = courtobject?["coordinateslat"]
                 let long = courtobject?["coordinateslong"]
                 let indoor = courtobject?["indoor"]
                 let membership = courtobject?["membership"]
                 let courtkey2 = courts.key
                let annotation = MKPointAnnotation()
                annotation.title = (parkname! as! String)
                annotation.coordinate = CLLocationCoordinate2DMake(lat as! CLLocationDegrees,long as! CLLocationDegrees)
                
                //checks if the the database is cycling on the selected annotation
                if((annotation.coordinate.longitude == ((view.annotation?.coordinate.longitude)! as Double)) && (annotation.coordinate.latitude == ((view.annotation?.coordinate.latitude)! as Double))){
                    self.clickedannotation = view.annotation
                    self.chosencourt = Court(coordinates: self.clickedannotation!.coordinate, parkname: parkname! as! String, numcourts: numcourts! as! Int, Address: (address as! String), indoor: indoor! as! Bool, membership: membership! as! Bool, courtid: courtkey2)
                    self.performSegue(withIdentifier: "home_gamemenu_segue", sender: MKAnnotationView.self)
                }
                
            }
                

            
     }

 })


    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        
        if let MainVC = destinationViewController as? Gamemenuviewcontroller{

            
            MainVC.user24 = user24
            
            MainVC.chosencourt = chosencourt
                        
        }
    }
}
    
    
    
    
 
