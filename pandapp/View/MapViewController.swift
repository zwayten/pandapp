//
//  MapViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 7/11/2021.
//

import UIKit
import MapKit
//import CoreLocation

class MapViewController: UIViewController,MKMapViewDelegate,UIGestureRecognizerDelegate,CLLocationManagerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var nomStade: UITextField!

    @IBOutlet weak var descStade: UITextField!

    @IBOutlet weak var numStade: UITextField!

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var addImageButton: UIButton!

    var longitudeVal : Double?

    var latitudeVal : Double?

    var myGeoCoder = CLGeocoder()
    var locationManager  = CLLocationManager()
    override func viewDidLoad() {

        super.viewDidLoad()
        locationManager.delegate = self

        mapView.delegate = self

        let oLongTapGerture = UILongPressGestureRecognizer(target: self, action:#selector(MapViewController.handleLongtapGesture(gestureRecognizer:)))
        self.mapView.addGestureRecognizer(oLongTapGerture)

    }
    @IBAction func saveLocation(_ sender: Any) {
        let userid = UserDefaults.standard.string(forKey: "email")
        if longitudeVal == nil && latitudeVal == nil{
            
            print("rahou nulllllllllllllllllllllllllllllllll")
         
        }
        else{
        let parking = Parking(longatitude: longitudeVal!, latatitude: latitudeVal!, userId: userid!)
        let pvm = ParkingViewModel()
        pvm.addParking(parking: parking)
            }}
    @objc func handleLongtapGesture(gestureRecognizer : UILongPressGestureRecognizer){

        if gestureRecognizer.state != UIGestureRecognizer.State.ended{

            let touchLocation = gestureRecognizer.location(in: mapView)

            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)

            latitudeVal = locationCoordinate.latitude

            longitudeVal = locationCoordinate.longitude

            print("latitude: \(locationCoordinate.latitude), Longitude:  \(locationCoordinate.longitude)")

            

            let myPin = MKPointAnnotation()

            myPin.coordinate = locationCoordinate



            myPin.title = " latitude: \(locationCoordinate.latitude), Longitude\(locationCoordinate.longitude)"

            mapView.addAnnotation(myPin)

        }

        

        if gestureRecognizer.state != UIGestureRecognizer.State.began

        {

            return

        }

    }



}
