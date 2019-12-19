//
//  Message.swift
//  Show-me-chat
//
//  Created by Mark Dorofeev on 19/12/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import Foundation
import UIKit


struct Message {
    let user: User
    let content: String
    let isIncoming: Bool
}

extension Message {
    init(userId: String, textMessage: String, isIncoming: Bool) {
        user = User(name: userId)
        content = textMessage
        self.isIncoming = isIncoming
    }
}
