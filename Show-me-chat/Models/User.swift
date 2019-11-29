//
//  User.swift
//  Show-me-chat
//
//  Created by Mark Dorofeev on 29/11/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import Foundation

class User {
    
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
