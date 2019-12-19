//
//  MessageTableViewCell.swift
//  Show-me-chat
//
//  Created by Mark Dorofeev on 19/12/2019.
//  Copyright © 2019 Mark Dorofeev. All rights reserved.
//

import UIKit

protocol MessageCell: class {
  var message: Message? { get set }
  var showsAvatar: Bool { get set }
}
