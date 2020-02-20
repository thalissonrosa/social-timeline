//
//  Post.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 17/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import UIKit

struct Post {

    let message: String
    let user: String
    let timestamp: Double
}

extension Post {

    func toAnyObject() -> Any {
        return [
            "message": message,
            "user": user,
            "timestamp": timestamp
        ]
    }

    static func fromDictionary(_ dict: NSDictionary) -> Post? {
        guard let message = dict["message"] as? String,
            let user = dict["user"] as? String,
            let timestamp = dict["timestamp"] as? Double else { return nil }
        return Post(message: message, user: user, timestamp: timestamp)
     }
}
