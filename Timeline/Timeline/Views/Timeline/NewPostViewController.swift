//
//  NewPostViewController.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 18/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class NewPostViewController: UIViewController {

    var viewModel: NewPostViewModel?
    private let disposeBag = DisposeBag()

    // MARK: - Outlets
    
    @IBOutlet private var headerLabel: UILabel!
    @IBOutlet private var cancelButton: UIButton!
    @IBOutlet private var postButton: UIButton!
    @IBOutlet private var postTextView: UITextView! {
        didSet {
            postTextView.becomeFirstResponder()
        }
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    // MARK: - IBActions

    @IBAction func postPressed() {
        viewModel?.addPost().subscribe(onCompleted: { [weak self] in
            self?.dismiss(animated: true)
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }

    @IBAction func cancelPressed() {
        dismiss(animated: true)
    }
}

// MARK: - Private methods

private extension NewPostViewController {

    func setupBindings() {
        guard let viewModel = viewModel else { return }
        postTextView.rx.text
            .bind(to: viewModel.postMessage)
            .disposed(by: disposeBag)
        viewModel.isPostButtonEnabled
            .bind(to: postButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
