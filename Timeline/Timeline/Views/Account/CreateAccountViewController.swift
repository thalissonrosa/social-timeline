//
//  CreateAccountViewController.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 15/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateAccountViewController: UIViewController {

    var viewModel: CreateAccountViewModel = CreateAccountViewModel()

    // MARK: - Private properties

    private let disposeBag = DisposeBag()

    // MARK: - Outlets

    @IBOutlet private var headerLabel: UILabel!
    @IBOutlet private var emailTextField: SocialTimelineTextField!
    @IBOutlet private var passwordTextField: SocialTimelineTextField!
    @IBOutlet private var confirmPasswordTextField: SocialTimelineTextField!
    @IBOutlet private var passwordMismatchLabel: UILabel!
    @IBOutlet private var createAccountButton: UIButton!
    @IBOutlet private var backButton: UIButton!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupLocalization()
    }

    // MARK: - IBActions

    @IBAction func createAccountPressed() {
        displayLoadingHUD(message: AppStrings.loading.localized)
        viewModel.createAccount().subscribe(onCompleted: { [weak self] in
            self?.hideLoadingHUD()
            self?.navigationController?.popViewController(animated: true)
        }) { [weak self] error in
            self?.hideLoadingHUD()
            self?.displayAppErrorAlert(error: error)
        }.disposed(by: disposeBag)
    }

    @IBAction func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private functions

private extension CreateAccountViewController {

    func setupBindings() {
        emailTextField.rx.text
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        passwordTextField.rx.text
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        confirmPasswordTextField.rx.text
            .bind(to: viewModel.confirmPassword)
            .disposed(by: disposeBag)
        viewModel.isCreateAccountButtonEnabled
            .bind(to: createAccountButton.rx.isEnabled)
            .disposed(by: disposeBag)
        viewModel.passwordMatches
            .bind(to: passwordMismatchLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }

    func setupLocalization() {
        headerLabel.text = AppStrings.createAccount.localized
        emailTextField.placeholder = AppStrings.email.localized
        passwordTextField.placeholder = AppStrings.password.localized
        confirmPasswordTextField.placeholder = AppStrings.confirmPassword.localized
        passwordMismatchLabel.text = AppStrings.passwordMismatch.localized
        createAccountButton.setTitle(AppStrings.createAccount.localized, for: .normal)
        backButton.setTitle(AppStrings.back.localized, for: .normal)
    }
}
