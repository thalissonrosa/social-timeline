//
//  NewPostViewController.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 18/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private var headerLabel: UILabel!
    @IBOutlet private var cancelButton: UIButton!
    @IBOutlet private var postButton: UIButton!
    @IBOutlet private var postTextField: UITextField! {
        didSet {
            postTextField.contentVerticalAlignment = .top
        }
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions

    @IBAction func cancelPressed() {
        navigationController?.dismiss(animated: true)
    }
}
