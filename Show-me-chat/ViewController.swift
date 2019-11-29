
//
//  ViewController.swift
//  Show-me-chat
//
//  Created by Anton Brichev, Oleg Krylov, Mark Dorofeev on 19/09/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController{



    override func viewDidLoad() {
         super.viewDidLoad()
        
                
        // Do any additional setup after loading the view.
        let camera = GMSCameraPosition.camera(withLatitude: 10, longitude: 10, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

        // Creates a marker in the center of the map.
        let position = CLLocationCoordinate2D(latitude: 10, longitude: 10)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = mapView
       
    }
}
