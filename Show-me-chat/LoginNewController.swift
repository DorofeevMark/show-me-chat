//
//  LoginNewController.swift
//  Show-me-chat
//
//  Created by 3oleg_krylov on 18/10/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI

class LoginController: UIViewController, FUIAuthDelegate{
    override func viewDidAppear(_ animated: Bool) {
    
        super.viewDidAppear(animated)
        
        let authUI = FUIAuth.defaultAuthUI()
        
        authUI?.delegate = self
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth()]

        authUI?.providers = providers
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
         self.authSuccess()
    }
    
    func authSuccess() {
        self.dismiss(animated: true, completion: nil)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "Map")
        self.present(loggedInViewController, animated: true, completion: nil)
    }
    
}
