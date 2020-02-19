//
//  TimelineViewModel.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 17/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import Foundation
import RxSwift

final class TimelineViewModel {

    // MARK: - Properties
    
    let user: User
    let accountService: AccountService
    private var posts: [Post] = []
    var numberOfPosts: Int {
        return posts.count
    }

    // MARK: - Init

    init(user: User, accountService: AccountService = FirebaseAccountService()) {
        self.user = user
        self.accountService = accountService
        let post1 = Post(message: "teste 1",
                         user: "talico15@gmail.com")
        let post2 = Post(message: "teste 2",
                         user: "fulano@gmail.com")
        let post3 = Post(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sapien sapien, imperdiet id urna et, faucibus tempus augue. Nulla posuere molestie hendrerit. Donec metus massa, rhoncus eget arcu ut, tempus suscipit tellus.",
                         user: "loremIpsum@gmail.com")
        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
    }

    // MARK: - Functions

    func logout() -> Completable {
        return accountService.logout()
    }

    func canErasePostAt(index: Int) -> Bool {
        return posts[index].user == user.username
    }

    func postAt(index: Int) -> Post {
        return posts[index]
    }

    func removePostAt(index: Int) {
        posts.remove(at: index)
    }
}
