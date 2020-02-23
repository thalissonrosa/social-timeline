//
//  NewPostViewModel.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 18/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import RxCocoa
import RxSwift

final class NewPostViewModel {

    // MARK: Properties

    let user: User
    let timelineService: TimelineService
    var postMessage = BehaviorRelay<String?>(value: "")
    var isPostButtonEnabled: Observable<Bool> {
        return postMessage.asObservable().map { text -> Bool in
            let textCount = text?.count ?? 0
            return textCount > 0
        }
    }

    // MARK: Init

    init(user: User, timelineService: TimelineService = FirebaseTimelineService()) {
        self.user = user
        self.timelineService = timelineService
    }

    // MARK: Functions

    func addPost() -> Completable {
        guard let message = postMessage.value else {
            let error = TimelineError(message: "", errorCode: .timelineError)
            return Completable.error(error)
        }
        return timelineService.createPost(message, from: user)
    }
}
