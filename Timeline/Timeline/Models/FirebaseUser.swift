//
//  FirebaseUser.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 15/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import Firebase

struct FirebaseUser: User {

    var username: String
    var identifier: String

    init(user: Firebase.User) {
        username = user.email ?? ""
        identifier = user.uid
    }
}
