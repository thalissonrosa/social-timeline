//
//  TimelineError.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 15/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import UIKit

enum ErrorCode {
    case genericError
    case authError
    case timelineError

    var title: String {
        switch self {
        case .genericError:
            return AppStrings.genericError.localized
        case .authError:
            return AppStrings.authError.localized
        case .timelineError:
            return AppStrings.timelineError.localized
        }
    }
}

protocol GenericError: Error {
    var message: String? { get }
    var code: ErrorCode { get }
}

struct TimelineError: GenericError {

    var message: String?
    var code: ErrorCode

    init(message: String? = nil, errorCode: ErrorCode = .genericError) {
        self.message = message
        self.code = errorCode
    }
}
