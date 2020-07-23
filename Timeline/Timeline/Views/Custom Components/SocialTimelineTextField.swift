//
//  SocialTimelineTextField.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 22/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class SocialTimelineTextField: UITextField {

    @IBOutlet open weak var nextFieldResponder: UIResponder?

    override open func awakeFromNib() {
      super.awakeFromNib()
      setupEventHandlers()
    }
}

private extension SocialTimelineTextField {

    private func setupEventHandlers() {
      addTarget(self,
                action: #selector(didTapKeyboardNextButton(sender:)),
                for: .editingDidEndOnExit)
    }

    @objc func didTapKeyboardNextButton(sender: UITextField) {
        switch nextFieldResponder {
        case .some(let responder):
            responder.becomeFirstResponder()
        default:
            resignFirstResponder()
        }
    }
}
