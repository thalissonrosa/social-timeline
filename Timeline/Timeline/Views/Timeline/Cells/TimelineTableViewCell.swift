//
//  TimelineTableViewCell.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 17/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {

    static let identifier = "TimelineTableViewCell"

    // MARK: - IBOutlets

    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!

    // MARK: - Overriden Methods

    override func prepareForReuse() {
        messageLabel.text = nil
        authorLabel.text = nil
    }

    // MARK: - Functions

    func configure(post: Post) {
        messageLabel.text = post.message
        authorLabel.text = post.userEmail
    }
}
