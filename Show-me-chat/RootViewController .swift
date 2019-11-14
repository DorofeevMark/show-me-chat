//
//  RootViewController .swift
//  Show-me-chat
//
//  Created by 3oleg_krylov on 18/10/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UINavigationController{
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Chat")
        self.present(controller, animated: true, completion: nil)
    }
}
