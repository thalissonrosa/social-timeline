//
//  ViewController.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 15/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class SignInViewController: UIViewController {

    // MARK: - Properties

    var viewModel: SignInViewModel = SignInViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - IBOutlets

    @IBOutlet private var welcomeLabel: UILabel!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var createAccountButton: UIButton!

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupLocalization()
    }

    // MARK: - IBActions

    @IBAction func loginPressed() {
        viewModel.login().subscribe(onNext: { user in
            print(user.username)
            //TODO: Move to the Timeline screen
        }, onError: { error in
            //TODO: Display the error to the user
        }).disposed(by: disposeBag)
    }

    @IBAction func createAccountPressed() {
        guard let viewController = R.storyboard.account.createAccountViewController() else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Private methods

private extension SignInViewController {

    func setupBindings() {
        emailTextField.rx.text
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        passwordTextField.rx.text
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        viewModel.isLoginButtonEnabled
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    func setupLocalization() {
        welcomeLabel.text = AppStrings.welcome.localized
        emailTextField.placeholder = AppStrings.email.localized
        passwordTextField.placeholder = AppStrings.password.localized
        loginButton.setTitle(AppStrings.login.localized, for: .normal)
        createAccountButton.setTitle(AppStrings.createAccount.localized, for: .normal)
    }
}
