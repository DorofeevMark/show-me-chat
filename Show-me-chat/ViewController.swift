
//
//  ViewController.swift
//  Show-me-chat
//
//  Created by Anton Brichev, Oleg Krylov, Mark Dorofeev on 19/09/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import UIKit
import YandexMapKit

class ViewController: UIViewController{

   
    @IBOutlet weak var mapView: YMKMapView! //Yandex map

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.mapWindow.map.move(
        with: YMKCameraPosition.init(target: YMKPoint(latitude: 59.9558213, longitude: 30.3209282), zoom: 15, azimuth: 0, tilt: 0),
        animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
        cameraCallback: nil)
    
        
    }
}
