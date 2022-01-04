//
//  mapSimpleUserViewController.swift
//  pandapp
//
//  Created by Mac2021 on 3/1/2022.
//

import UIKit
import MapKit
import Alamofire


class mapSimpleUserViewController: UIViewController , UISearchBarDelegate{
    
    
    
    
    
    var locationManager: CLLocationManager!

    //var mapView: MKMapView!
    
    @IBOutlet var mapView: MKMapView!
    
    let centerMapButton: UIButton = {

        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)


       // button.setImage(#imageLiteral(resourceName: "location-arrow-flat").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCenterLocation), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        return button

    }()

    

    // MARK: - Init


    
    var annotationsLocation = [[String : Any]]()
    var myresult = [Parking]()
//    let annotationsLocation = [
// ["longitude": 10.689226695846768, "latitude": 34.770598137766015, "title": "Nill"], ["title": "yassine", "latitude": 36.76721868062337, "longitude": 10.190588335688258]]
    override func viewDidAppear(_ animated: Bool) {
        configureLocationManager()
        configureMapView()
        enableLocationServices()
        var token: String?
        let lastLogged = UserDefaults.standard.string(forKey: "lastLoggedIn")
        if lastLogged! == "user" {
         token = UserDefaults.standard.string(forKey: "token")
        }
        else if lastLogged == "club" {
             token = UserDefaults.standard.string(forKey: "tokenClub")
            }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        
        
        AF.request("\(ConnectionDb.baserequest())parking", method: .get , headers: headers ).responseDecodable(of: [Parking].self) { [weak self] response in
            self?.myresult = response.value ?? []
                
                
            for i in self!.myresult{
                print("\(i.longatitude) lat ::::: \(i.latatitude), \(i.userId)")
                    self?.annotationsLocation.append(
                        ["title": i.userId, "latitude": i.latatitude, "longitude": i.longatitude])
                    let annotations = MKPointAnnotation()

                annotations.title = i.userId as? String
                    
                print(i.latatitude)

                    print("hhhhhhhhhghhgghghghgghg")


                annotations.coordinate = CLLocationCoordinate2D(latitude: i.latatitude as! CLLocationDegrees, longitude: i.longatitude as! CLLocationDegrees)



                    

                    self?.mapView.addAnnotation(annotations)


                }
                //self.mapView.region
                print(self?.annotationsLocation)
                



            
        }
//        configureLocationManager()
//
//        configureMapView()
//
//        enableLocationServices()
//
//        createAnnotation(locations:annotationsLocation)

    }
    override func viewDidLoad() {
        configureLocationManager()
        configureMapView()
        enableLocationServices()

        super.viewDidLoad()

       
    }

    

    // MARK: - Selectors
    

    @objc func handleCenterLocation() {

        centerMapOnUserLocation()

        centerMapButton.alpha = 0

    }

    

    // MARK: - Helper Functions
    

    func configureLocationManager() {

        locationManager = CLLocationManager()

        locationManager.delegate = self

    }

    

    func configureMapView() {

        mapView = MKMapView()

        mapView.showsUserLocation = true

        mapView.delegate = self

        mapView.userTrackingMode = .follow

        

        view.addSubview(mapView)

        mapView.frame = view.frame
        

        

        view.addSubview(centerMapButton)

        centerMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44).isActive = true

        centerMapButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true

        centerMapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        centerMapButton.widthAnchor.constraint(equalToConstant: 50).isActive = true

        centerMapButton.layer.cornerRadius = 50 / 2

        centerMapButton.alpha = 1

    }

    

    func centerMapOnUserLocation() {

        guard let coordinate = locationManager.location?.coordinate else { return }

        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)

        mapView.setRegion(region, animated: true)

    }

    

    
        
        
  

    func createAnnotation(locations: [[String : Any]]) {

        for location in locations {
            print(location)

            let annotations = MKPointAnnotation()

            annotations.title = location["title"] as? String
            print("hhhhhhhhhghhgghghghgghg")
            print(location["title"])

            print("hhhhhhhhhghhgghghghgghg")


            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"]as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)



            

        mapView.addAnnotation(annotations)

        }

    }

    }



extension mapSimpleUserViewController: MKMapViewDelegate {

    

    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {

        UIView.animate(withDuration: 0.5) {

            self.centerMapButton.alpha = 1

        }

    }

    

    

}



// MARK: - CLLocationManagerDelegate


extension mapSimpleUserViewController: CLLocationManagerDelegate {

    

    func enableLocationServices() {

        switch CLLocationManager.authorizationStatus() {

        case .notDetermined:

            print("Location auth status is NOT DETERMINED")

            locationManager.requestWhenInUseAuthorization()

        case .restricted:

            print("Location auth status is RESTRICTED")

        case .denied:

            print("Location auth status is DENIED")

        case .authorizedAlways:

            print("Location auth status is AUTHORIZED ALWAYS")

        case .authorizedWhenInUse:

            print("Location auth status is AUTHORIZED WHEN IN USE")

            locationManager.startUpdatingLocation()

            locationManager.desiredAccuracy = kCLLocationAccuracyBest

        }

    }

    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        guard locationManager.location != nil else { return }

        centerMapOnUserLocation()

    }

}
