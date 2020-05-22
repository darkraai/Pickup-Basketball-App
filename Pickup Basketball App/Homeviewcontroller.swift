 
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
    
    //Users that will be loaded in irl
    var userayush = User(firstname: "Ayush", lastname: "Hariharan", username: "ayushluvshali", password: "fjwei", userweight: "160", hometown: "boo", userheightinches: "9", userheightfeet: "5", position: "SG", profilepic: UIImage(named: "ayush")!)
    var usersurya = User(firstname: "Surya", lastname: "Mamidyala", username: "suryam", password: "jfwoef", userweight: "105", hometown: "jfwe", userheightinches: "11", userheightfeet: "5", position: "SF", profilepic: UIImage(named: "surya")!)
    var useryash = User(firstname: "Yash", lastname: "Halal", username: "sirhalalyash", password: "fjwofej", userweight: "300", hometown: "pakistan", userheightinches: "4", userheightfeet: "4", position: "C", profilepic: UIImage(named: "yashipoo")!)
    var userben = User(firstname: "Ben", lastname: "Svoboda", username: "bensvo", password: "jfoewj", userweight: "215", hometown: "jfweo", userheightinches: "3", userheightfeet: "6", position: "PG", profilepic: UIImage(named: "ben")!)
    var userbik = User(firstname: "Bikram", lastname: "Kohli", username: "lightskinb", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "bik")!)
    var userxan = User(firstname: "Xan", lastname: "Manshoota", username: "xanmanshoota", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "xanman")!)
    var usertrey = User(firstname: "Trey", lastname: "Watts", username: "treyvonsteals", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "trey")!)
    var userawal = User(firstname: "Awal", lastname: "Awal", username: "awaldasnipa", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "aryan")!)
    
    //these parks will be loaded in IRL
    lazy var applepark = Court(coordinates: CLLocationCoordinate2D(latitude: 37.332072300, longitude: -122.011138100), parkname: "Apple Park", numcourts: 2, Address: "Pleasantview Avenue", indoor: false, membership: false, game: [Game(timeslot: "1-2 pm", gametype: "5 v 5", creator: userben!.username, slotsfilled: 8, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!,usertrey!,userawal!],date: "May 19, 2020")!,Game(timeslot: "2-3 pm", gametype: "3 v 3", creator: usersurya!.username, slotsfilled: 6, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!],date: "May 20, 2020")!,Game(timeslot: "10-11 am", gametype: "2 v 2", creator: userxan!.username, slotsfilled: 3, team1: [userayush!,usersurya!], team2: [userben!],date: "May 20, 2020")!,Game(timeslot: "3-4 pm", gametype: "3 v 3", creator: userbik!.username, slotsfilled: 4, team1: [userayush!,usersurya!], team2: [userben!,userbik!],date: "May 20, 2020")!])
    
    lazy var ortegapark = Court(coordinates: CLLocationCoordinate2D(latitude: 37.342226, longitude: -122.025617), parkname: "Ortega Park", numcourts: 2, Address: "Mexi Avenue", indoor: false, membership: true, game: [Game(timeslot: "1-2 pm", gametype: "5 v 5", creator: userben!.username, slotsfilled: 8, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!,usertrey!,userawal!],date: "May 19, 2020")!,Game(timeslot: "2-3 pm", gametype: "3 v 3", creator: usersurya!.username, slotsfilled: 6, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!],date: "May 19, 2020")!,Game(timeslot: "10-11 am", gametype: "2 v 2", creator: userxan!.username, slotsfilled: 3, team1: [userayush!,usersurya!], team2: [useryash!],date: "May 22, 2020")!,Game(timeslot: "3-4 pm", gametype: "3 v 3", creator: userbik!.username, slotsfilled: 4, team1: [usersurya!,useryash!], team2: [userbik!,userxan!],date: "May 22, 2020")!])
    
    //courts will be loaded in automatically irl
    lazy var allcourts:[Court] = [applepark!,ortegapark!]
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    var locCoord: CLLocationCoordinate2D?
    var annotation: MKPointAnnotation?
    var alert = false
    
//    private var destinations: [MKPointAnnotation] = []
//    private var currentRoute: MKRoute?
 
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print("Loaded sucessfully2")
        mapView.delegate = self
        
//        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        longPressRecognizer.minimumPressDuration = 0.2
//        mapView.addGestureRecognizer(longPressRecognizer)
        
        configureLocationServices()
 
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        if (alert == true){
    //            presentAlert()
    //            alert = false
    //        }
    //    }
    
    private func presentAlert(){
        let alertController = UIAlertController(title: "Court added!", message: "The court requested has successfuly been added.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
        if segue.source is Tabnewcourtviewcontroller{
            zoomToLatestLocation(with: annotation!.coordinate)
            mapView.addAnnotation(annotation!)
//            presentAlert()
        }
    }
    
//    @objc func handleTap(_ gestureRecognizer: UILongPressGestureRecognizer) {
//        let location = gestureRecognizer.location(in: mapView) //gives the location object of where you are clicking on mapView
//        locCoord = mapView.convert(location, toCoordinateFrom: mapView) //converts location object to coordinates
//
//        let annotation = MKPointAnnotation()
//
//        annotation.coordinate = locCoord!
//        annotation.title = "latitude:" + String(format: "%0.02f", annotation.coordinate.latitude) + "& longitude:" + String(format: "%0.02f", annotation.coordinate.longitude)
//        annotation.subtitle = "Loc of new bball court"
//
//    //  self.mapView.removeAnnotations(mapView.annotations)
//        mapView.addAnnotation(annotation)
////        performSegue(withIdentifier: "addCourtSegue", sender: UILongPressGestureRecognizer.self)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Newcourtviewcontroller") as! Newcourtviewcontroller
//        self.present(nextViewController, animated:true, completion:nil)
//    }
    
//    func prepare(for segue: UIStoryboardSegue, sender: UILongPressGestureRecognizer) {
//        super.prepare(for: segue, sender: sender)
//        let vc = segue.destination as! Newcourtviewcontroller
//        vc.locCoord = self.locCoord
//    }
    
    
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
        let appleParkAnnotation = MKPointAnnotation()
        appleParkAnnotation.title = applepark!.parkname
        appleParkAnnotation.coordinate = applepark!.coordinates!
        
        let ortegaParkAnnotation = MKPointAnnotation()
        ortegaParkAnnotation.title = ortegapark!.parkname
        ortegaParkAnnotation.coordinate = ortegapark!.coordinates!
        
//        destinations.append(appleParkAnnotation)
//        destinations.append(ortegaParkAnnotation)
        
        let annotations: [MKAnnotation] = [appleParkAnnotation, ortegaParkAnnotation]
        
        mapView.addAnnotations(annotations)
        
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
 
extension Homeviewcontroller: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("Just got latest location and updated map...")
        
        guard let latestLocation = locations.first else { return }
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
            addAnnotations()
//            constructRoute(userLocation: latestLocation.coordinate)
        }
        currentCoordinate = latestLocation.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //print("Authorization status changed!")
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            beginLocationUpdates(locationManager: manager)
        }
    }
}
 
extension Homeviewcontroller: MKMapViewDelegate {
    
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
        //print("The annotation was selected: \(String(describing: view.annotation?.title))")
        for x in allcourts{
            if(view.annotation!.title!! == x.parkname){
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
                if(clickedannotation!.title!! == x.parkname){
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
    
    
    
    
 
