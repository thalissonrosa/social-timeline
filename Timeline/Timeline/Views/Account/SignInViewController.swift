//
//  ViewController.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 15/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import MBProgressHUD
import RxCocoa
import RxSwift
import UIKit

final class SignInViewController: UIViewController {

    // MARK: - Properties

    var viewModel: SignInViewModel = SignInViewModel()
    private let disposeBag = DisposeBag()
    private var loadingHUD: MBProgressHUD?

    // MARK: - IBOutlets

    @IBOutlet private var welcomeLabel: UILabel!
    @IBOutlet private var emailTextField: SocialTimelineTextField! 
    @IBOutlet private var passwordTextField: SocialTimelineTextField!
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
        displayLoadingHUD(message: AppStrings.loading.localized)
        viewModel.login().subscribe(onSuccess: { [weak self] user in
            guard let timelineController = R.storyboard.timeline.timelineViewController() else {
                return
            }
            let viewModel = TimelineViewModel(user: user)
            timelineController.viewModel = viewModel
            self?.hideLoadingHUD()
            self?.navigationController?.pushViewController(timelineController,
                                                          animated: true)
        }, onError: { [weak self] error in
            self?.hideLoadingHUD()
            self?.displayAppErrorAlert(error: error)
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
