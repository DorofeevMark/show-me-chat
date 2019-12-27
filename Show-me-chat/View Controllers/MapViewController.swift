
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
    var zoomLevel: Float = 5.0
    var db : Firestore!
    var is_creating = false
    var markerIsAlive = false
    var temp : CustomInfoWindow!
    var creatingWindow : CreatingWindow!
    var documentID : String = ""
    var markers = [GMSMarker]()
    var marker: GMSMarker!
    var coordinates: CLLocationCoordinate2D!
    
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
                        marker.userData = document.documentID
                        self.markers.append(marker)

                    }
                }
        }
    
        self.temp = CustomInfoWindow().loadViewFromNib(frame: CGRect(x: Constants_.ScreenParameters.width / 2 - 100 , y:  Constants_.ScreenParameters.height / 2 - 250 , width: 200, height: 200))
        
       self.creatingWindow = CreatingWindow().loadViewFromNib(frame: CGRect(x: Constants_.ScreenParameters.width / 2 - 100 , y:  Constants_.ScreenParameters.height / 2 - 250 , width: 200, height: 200))
        
        mapView.delegate = self
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Create chat", style: .plain, target: self, action: #selector(createChat))
        
      
    }
    

   
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if(!is_creating){
            mapView.camera =  GMSCameraPosition.camera(withLatitude: marker.position.latitude, longitude: marker.position.longitude, zoom: mapView.camera.zoom)
            self.documentID = marker.userData as! String
            let docRef = db.collection("chats").document(documentID)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                        let userChatRef = document.data()?["userChat"] as! DocumentReference
                        userChatRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                let dataDescription = document.data()?["userIds"] as! [String]
                                self.temp.label_.text = String(dataDescription.count) + "/50"
                            } else {
                                print("Document does not exist")
                            }
                        }
                    
                } else {
                    print("Document does not exist")
                }
            }
            temp.button_.addTarget(self, action: #selector(MapViewController.buttonTapped(_:)), for: .touchUpInside)
            self.view.addSubview(temp)
            return false
        }
        return true
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView();
    }
    
    

    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        temp.removeFromSuperview()
        if(is_creating){
            mapView.settings.scrollGestures = false
             navigationItem.leftBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(stopCreating))
            mapView.camera =  GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: mapView.camera.zoom)
            creatingWindow.buttonYes.addTarget(self, action: #selector(MapViewController.createButtonTappedYes(_:)), for: .touchUpInside)
            creatingWindow.buttonNo.addTarget(self, action: #selector(MapViewController.createButtonTappedNo(_:)), for: .touchUpInside)
            self.view.addSubview(creatingWindow)
            if(markerIsAlive){
                marker.map = nil
            }
            marker = GMSMarker(position: coordinate)
            marker.map = self.mapView
            coordinates = coordinate
            markerIsAlive = true
            
        }
    }
    

    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        temp.removeFromSuperview()
    }
    
    @objc func buttonTapped(_ sender: UIButton!) {
    
        let user = Auth.auth().currentUser
        if let user = user {
           let userId = user.uid
            let url_ = "https://us-central1-show-me-chat.cloudfunctions.net/addUserToChat?"
            let url = URL(string: url_ + "userId=" +  String(userId) + "&chatId=" + String(self.documentID))!
        
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                        guard let data = data else {return}
                        print(String(data: data, encoding: .utf8)!)
            }
            task.resume()
        }
            
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChatWindow") as! ChatViewController
        controller.chatId = String(self.documentID)
        
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @objc func addTapped() {
        do {
            try Auth.auth().signOut()
        } catch _ as NSError {
            // Show error message
        }
    }
    
    @objc func createChat(){
        is_creating = true
    }
    
    @objc func stopCreating(){
        mapView.settings.scrollGestures = true
        is_creating = false
        creatingWindow.removeFromSuperview()
        marker.map = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Create chat", style: .plain, target: self, action: #selector(createChat))
    }
    
    @objc func createButtonTappedYes(_ sender: UIButton!) {
        creatingWindow.removeFromSuperview()
        let user = Auth.auth().currentUser
        if let user = user {
           let userId = user.uid
            let url_ = "https://us-central1-show-me-chat.cloudfunctions.net/addChat?userId="
            let stringId = String(userId)
            let stringLat = String(coordinates.latitude)
            let stringLong = String(coordinates.longitude)
            let url = URL(string: url_ + stringId + "&longitude=" + stringLong + "&latitude=" + stringLat)!
            
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                        guard let data = data else {return}
                        print(String(data: data, encoding: .utf8)!)
            }
            task.resume()
            marker.userData = stringId
            self.markers.append(marker)
            marker.map = nil
            is_creating = false
            mapView.settings.scrollGestures = true
        }

       
    }
    
    @objc func createButtonTappedNo(_ sender: UIButton!) {
        mapView.settings.scrollGestures = true
        marker.map = nil
        creatingWindow.removeFromSuperview()
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
        default:
            print("default")
        }
        
        print(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
