//
//  HomeViewController.swift
//  Show-me-chat
//
//  Created by Mark Dorofeev on 29/11/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import Foundation
import Firebase

class HomeViewController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        let firstViewController = MapViewController()
//
//        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//        
//        let secondViewController = ChatViewController()
//        
//        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
//        
//        let tabBarList = [firstViewController, secondViewController]
//        
//        
//        self.viewControllers = tabBarList
        
//        navigationItem.hidesBackButton = true
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(addTapped))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Create chat", style: .plain, target: self, action: #selector(createChat))
    }
}
