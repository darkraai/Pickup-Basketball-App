 
//
//  HomeViewController.swift
//  Pickup Basketball App
//
//  Created by Surya M on 3/22/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
 
import UIKit
import MapKit
 
class Homeviewcontroller: UIViewController, UISearchBarDelegate {
    
    var user24:User?
    
    var clickedannotation:MKAnnotation?
    
    var currentCoordinate: CLLocationCoordinate2D?
    
    var annotation: MKPointAnnotation?
    
    let locationManager = CLLocationManager()
    
    //Users that will be loaded in irl
    var userayush = User(firstname: "Ayush", lastname: "Hariharan", username: "ayushluvshali", password: "fjwei", userweight: "160", hometown: "boo", userheightinches: "9", userheightfeet: "5", position: "SG", profilepic: UIImage(named: "ayush")!, pfplink: "N/A")
    var usersurya = User(firstname: "Surya", lastname: "Mamidyala", username: "suryam", password: "jfwoef", userweight: "105", hometown: "jfwe", userheightinches: "11", userheightfeet: "5", position: "SF", profilepic: UIImage(named: "surya")!, pfplink: "N/A")
    var useryash = User(firstname: "Yash", lastname: "Halal", username: "sirhalalyash", password: "fjwofej", userweight: "300", hometown: "pakistan", userheightinches: "4", userheightfeet: "4", position: "C", profilepic: UIImage(named: "yashipoo")!, pfplink: "N/A")
    var userben = User(firstname: "Ben", lastname: "Svoboda", username: "bensvo", password: "jfoewj", userweight: "215", hometown: "jfweo", userheightinches: "3", userheightfeet: "6", position: "PG", profilepic: UIImage(named: "ben")!, pfplink: "N/A")
    var userbik = User(firstname: "Bikram", lastname: "Kohli", username: "lightskinb", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "bik")!, pfplink: "N/A")
    var userxan = User(firstname: "Xan", lastname: "Manshoota", username: "xanmanshoota", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "xanman")!, pfplink: "N/A")
    var usertrey = User(firstname: "Trey", lastname: "Watts", username: "treyvonsteals", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "trey")!, pfplink: "N/A")
    var userawal = User(firstname: "Awal", lastname: "Awal", username: "awaldasnipa", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "aryan")!, pfplink: "N/A")
    
    //these parks will be loaded in IRL
    lazy var applepark = Court(coordinates: CLLocationCoordinate2D(latitude: 37.332072300, longitude: -122.011138100), parkname: "Apple Park", numcourts: 2, Address: "Pleasantview Avenue", indoor: false, membership: false, game: [Game(timeslot: "1-2 pm", gametype: "5 v 5", creator: userben!.username, slotsfilled: 8, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!,usertrey!,userawal!],date: "May 19, 2020")!,Game(timeslot: "2-3 pm", gametype: "3 v 3", creator: usersurya!.username, slotsfilled: 6, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!],date: "May 20, 2020")!,Game(timeslot: "10-11 am", gametype: "2 v 2", creator: userxan!.username, slotsfilled: 3, team1: [userayush!,usersurya!], team2: [userben!],date: "May 20, 2020")!,Game(timeslot: "3-4 pm", gametype: "3 v 3", creator: userbik!.username, slotsfilled: 4, team1: [userayush!,usersurya!], team2: [userben!,userbik!],date: "May 20, 2020")!])
    
    lazy var ortegapark = Court(coordinates: CLLocationCoordinate2D(latitude: 37.342226, longitude: -122.025617), parkname: "Ortega Park", numcourts: 2, Address: "Mexi Avenue", indoor: false, membership: true, game: [Game(timeslot: "1-2 pm", gametype: "5 v 5", creator: userben!.username, slotsfilled: 8, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!,usertrey!,userawal!],date: "May 23, 2020")!,Game(timeslot: "2-3 pm", gametype: "3 v 3", creator: usersurya!.username, slotsfilled: 6, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!],date: "May 23, 2020")!,Game(timeslot: "10-11 am", gametype: "2 v 2", creator: userxan!.username, slotsfilled: 3, team1: [userayush!,usersurya!], team2: [useryash!],date: "May 24, 2020")!,Game(timeslot: "3-4 pm", gametype: "3 v 3", creator: userbik!.username, slotsfilled: 4, team1: [usersurya!,useryash!], team2: [userbik!,userxan!],date: "May 24, 2020")!])
    
    //courts will be loaded in automatically irl
    lazy var allcourts:[Court] = [applepark!,ortegapark!]
 
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        configureLocationServices()
 
    }
    
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
        if segue.source is Tabnewcourtviewcontroller{
            zoomToLatestLocation(with: annotation!.coordinate)
            mapView.addAnnotation(annotation!)
            presentAlert()
        }
    }
    
    private func presentAlert(){
        let alertController = UIAlertController(title: "Court added!", message: "The court requested has successfuly been added.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
    
    private func addSampleAnnotations(){
        let appleParkAnnotation = MKPointAnnotation()
        appleParkAnnotation.title = applepark!.parkname
        appleParkAnnotation.coordinate = applepark!.coordinates!
        
        let ortegaParkAnnotation = MKPointAnnotation()
        ortegaParkAnnotation.title = ortegapark!.parkname
        ortegaParkAnnotation.coordinate = ortegapark!.coordinates!
        
        let annotations: [MKAnnotation] = [appleParkAnnotation, ortegaParkAnnotation]
        
        mapView.addAnnotations(annotations)
        
    }
        
 
}
 
extension Homeviewcontroller: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
            addSampleAnnotations()
        }
        
        currentCoordinate = latestLocation.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            beginLocationUpdates(locationManager: manager)
        }
        
    }
}
 
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
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        for x in allcourts{
            
            if(view.annotation!.title! == x.parkname){
                clickedannotation = view.annotation
            }
        }
        performSegue(withIdentifier: "home_gamemenu_segue", sender: MKAnnotationView.self)
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        
        if let MainVC = destinationViewController as? Gamemenuviewcontroller{
            let now = Date()

            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none

            let datetime = formatter.string(from: now)
            
            
            MainVC.user24 = user24
            
            for x in allcourts{
                
                if(clickedannotation!.title! == x.parkname){
                    MainVC.chosencourt = x
                }
            }

          //for some reason, with the below code only the first day works
          //here we need to make datetextField the current date
            for z in MainVC.chosencourt.game!{
                MainVC.alltimeslots.append(z)
            }

            for z in MainVC.alltimeslots{
                
                if(z.date! == datetime){
                    MainVC.currenttimeslots.append(z)
                }
            }
        }
    }
}
    
    
    
    
 
