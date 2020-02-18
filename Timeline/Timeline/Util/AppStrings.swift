//
//  AppStrings.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 15/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import UIKit

enum AppStrings: String {

    // MARK: - Account
    case accountCreation
    case confirmPassword
    case createAccount
    case email
    case login
    case missingEmailPassword
    case password
    case passwordMismatch

    //MARK: - General
    case welcome

    //MARK: - Timeline
    case title
    case newPost
    case logout

    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
