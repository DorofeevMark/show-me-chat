//
//  LoginNewController.swift
//  Show-me-chat
//
//  Created by 3oleg_krylov on 18/10/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import Foundation
import UIKit

class LoginNewController: UIViewController{
    
    @IBOutlet weak var buttonOPEN: UIButton!
    @IBAction func didTapOpenButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
