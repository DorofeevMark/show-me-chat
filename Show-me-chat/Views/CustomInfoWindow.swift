//
//  CustomInfoWindow.swift
//  Show-me-chat
//
//  Created by Mark Dorofeev on 06/12/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import UIKit

class CustomInfoWindow: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    class func instanceFromNib() -> CustomInfoWindow {
        return UINib(nibName: "CustomInfoWindow", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomInfoWindow
    }

}
