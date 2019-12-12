
//
//  ViewController.swift
//  Show-me-chat
//
//  Created by Anton Brichev, Oleg Krylov, Mark Dorofeev on 19/09/2019.
//  Copyright © 2019 Anton Brichev, Oleg Krylov, Mark Dorofeev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import GoogleMaps


class MapViewController: UIViewController, GMSMapViewDelegate{
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0
    var db : Firestore!
    var is_creating = false
    var customInfoWindow : CustomInfoWindow?
    var temp : CustomInfoWindow!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
       
        let camera = GMSCameraPosition.camera(withLatitude: 12, longitude: 12, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        view = mapView
        
        db = Firestore.firestore()
        
        db.collection("chats")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching messages: \(error!)")
                    return
                }
                for document in documents {
                    if((document.data()["isActive"]) != nil){
                        let coord = document.data()["coordinates"] as! GeoPoint
                        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude ))
                        marker.map = self.mapView
                    }
                }
        }
    
        self.temp = CustomInfoWindow().loadViewFromNib(frame: CGRect(x: Constants.ScreenParameters.width / 2 - 100 , y:  Constants.ScreenParameters.height / 2 - 250 , width: 200, height: 200))
        
        mapView.delegate = self
      
    }
    

   
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.camera =  GMSCameraPosition.camera(withLatitude: marker.position.latitude, longitude: marker.position.longitude, zoom: mapView.camera.zoom)
        temp.button_.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(temp)
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView();
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        temp.removeFromSuperview()
    }

    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        temp.removeFromSuperview()
    }
    
    @objc func buttonTapped(_ sender: UIButton!) {
      print("Yeah! Button is tapped!")
    }
    
    
    
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
//        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
//                                              longitude: location.coordinate.longitude,
//                                              zoom: zoomLevel)
//
//        if mapView.isHidden {
//            mapView.isHidden = false
//            mapView.camera = camera
//        } else {
//            mapView.animate(to: camera)
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
        //mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
        
        print(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
