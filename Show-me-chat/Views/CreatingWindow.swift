//
//  CreatingWindow.swift
//  Show-me-chat
//
//  Created by Антон Бричёв on 19.12.2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class CreatingWindow: UIView {

    @IBOutlet var view: UIView!    
    
    func loadViewFromNib(frame: CGRect) -> CreatingWindow {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CreatingWindow", bundle: bundle)
        view = nib.instantiate(withOwner: self, options: nil).first as! CreatingWindow
        view.frame = frame
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view as! CreatingWindow;
    }
}
