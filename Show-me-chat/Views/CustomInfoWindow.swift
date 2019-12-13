//
//  CustomInfoWindow.swift
//  Show-me-chat
//
//  Created by Mark Dorofeev on 06/12/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class CustomInfoWindow: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var button_: UIButton!
    
    func loadViewFromNib(frame: CGRect) -> CustomInfoWindow {
        print("loadViewFromNib")
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomInfoWindow", bundle: bundle)
        view = nib.instantiate(withOwner: self, options: nil).first as! CustomInfoWindow
        view.frame = frame
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return view as! CustomInfoWindow;
    }
}
