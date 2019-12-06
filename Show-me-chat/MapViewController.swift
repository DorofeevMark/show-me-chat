
//
//  ViewController.swift
//  Show-me-chat
//
//  Created by Anton Brichev, Oleg Krylov, Mark Dorofeev on 19/09/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import UIKit
import GoogleMaps


class MapViewController: UIViewController, GMSMapViewDelegate{
    
    
    
    var customInfoWindow : InfoWindow?
    
   
    override func viewDidAppear(_ animated: Bool) {
    
        super.viewDidAppear(animated)
       

        // Do any additional setup after loading the view.
        let camera = GMSCameraPosition.camera(withLatitude: 10, longitude: 10, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let position = CLLocationCoordinate2D(latitude: 10, longitude: 10)
        let marker = GMSMarker(position: position)

        marker.map = mapView
    
        mapView.delegate = self
        
        
       
       
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
   
}
