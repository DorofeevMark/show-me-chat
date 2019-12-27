
//  MenuModel.swift
//  Show-me-chat
//
//  Created by 3oleg_krylov on 27.12.2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import Foundation
import UIKit

enum MenuModel: Int, CustomStringConvertible {
    
    case Profile
    case Menu
    case Contacts
    case Settings
    
    var description: String {
        switch self {
        case .Profile: return "Profile"
        case .Menu: return "Menu"
        case .Contacts: return "Contacts"
        case .Settings: return "Setting"
            
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile: return UIImage(named: "Profile") ?? UIImage()
        case .Menu: return UIImage(named: "Menu") ?? UIImage()
        case .Contacts: return UIImage(named: "Contacts") ?? UIImage()
        case .Settings: return UIImage(named: "Settings") ?? UIImage()
            
        }
    }
    
}

