
//
//  ViewController.swift
//  Show-me-chat
//
//  Created by Anton Brichev, Oleg Krylov, Mark Dorofeev on 19/09/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController, FUIAuthDelegate{
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if Auth.auth().currentUser != nil {
//            //do something
//        } else {
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self
//            let authUI = FUIAuth.defaultAuthUI()
//            authUI?.delegate = self
//            let providers: [FUIAuthProvider] = [
//                FUIGoogleAuth()]
//
//            authUI?.providers = providers
//            let authViewController = authUI!.authViewController()
//            self.present(authViewController, animated: true, completion: nil)
//        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "main")
        self.present(loggedInViewController, animated: true, completion: nil)
    }
}
