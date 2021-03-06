//
//  CALayer+Extensions.swift
//  Show-me-chat
//
//  Created by Mark Dorofeev on 19/12/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func addShadow(color: UIColor, offset: CGSize, radius: CGFloat) {
        shadowColor = color.cgColor
        shadowOffset =  offset
        shadowRadius = radius
        shadowOpacity = 1
    }
    
    func addBottomBorder(color: UIColor = .separator, width: CGFloat = 1) {
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(
            x: 0,
            y: frame.height - 1,
            width: frame.width,
            height: width)
        borderLayer.backgroundColor = color.cgColor
        addSublayer(borderLayer)
    }
}
