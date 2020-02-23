//
//  UIViewController+HUD.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 22/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import MBProgressHUD

extension UIViewController {

    func displayLoadingHUD(message: String) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .indeterminate
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.6)
        hud.label.text = message
    }

    func hideLoadingHUD() {
        MBProgressHUD.hide(for: view, animated: true)
    }

    func displayAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: AppStrings.ok.localized,
                                                style: .cancel))
        present(alertController, animated: true)
    }

    func displayAppErrorAlert(error: Error) {
        guard let appError = error as? TimelineError else { return }
        displayAlert(title: appError.code.title, message: appError.message)
    }
}
