//
//  CustomInfoWindow.swift
//  Show-me-chat
//
//  Created by Mark Dorofeev on 06/12/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import UIKit

class CustomInfoWindow: UIView {

 
    @IBAction func push(_ sender: UIButton) {
        print("button pressed")
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame);
        loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomInfoWindow", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view);

    }


}
