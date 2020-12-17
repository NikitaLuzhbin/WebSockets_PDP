//
//  ChatMessageCell.swift
//  WebSockets_PDP
//
//  Created by Никита Лужбин on 17.12.2020.
//  Copyright © 2020 flatstack. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    // MARK: Type Properties

    static var reuseIdentifier = "ChatMessageCell"

    // MARK: - Instance Properties

    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!

    // MARK: -

    var author: String? {
        get {
            return self.authorLabel.text
        }

        set {
            self.authorLabel.text = newValue
        }
    }

    var message: String? {
        get {
            return self.messageLabel.text
        }

        set {
            self.messageLabel.text = newValue
        }
    }
}
