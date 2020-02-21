//
//  Post.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 17/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import UIKit

struct Post {

    struct Keys {
        static let message = "message"
        static let user = "user"
        static let timestamp = "timestamp"
    }

    let message: String
    let user: String
    let timestamp: Double
    var databaseKey: String? = nil
}

extension Post {

    func toAnyObject() -> Any {
        return [
            Keys.message: message,
            Keys.user: user,
            Keys.timestamp: timestamp
        ]
    }

    static func fromDictionary(_ dict: NSDictionary, key: String) -> Post? {
        guard let message = dict[Keys.message] as? String,
            let user = dict[Keys.user] as? String,
            let timestamp = dict[Keys.timestamp] as? Double else { return nil }
        return Post(message: message, user: user, timestamp: timestamp, databaseKey: key)
     }
}
