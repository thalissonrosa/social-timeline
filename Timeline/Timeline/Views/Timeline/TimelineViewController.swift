//
//  TimelineViewController.swift
//  Timeline
//
//  Created by Thalisson da Rosa on 17/02/20.
//  Copyright © 2020 Thalisson da Rosa. All rights reserved.
//

import UIKit
import RxSwift

class TimelineViewController: UIViewController {

    // MARK: - Properties

    var viewModel: TimelineViewModel?
    private let disposeBag = DisposeBag()

    // MARK: - Outlets

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var logoutButton: UIButton!
    @IBOutlet private var newPostButton: UIButton!
    @IBOutlet private var timelineTableView: UITableView! {
        didSet {
            timelineTableView.dataSource = self
            let cellNib = UINib(resource: R.nib.timelineTableViewCell)
            timelineTableView.register(cellNib,
                                       forCellReuseIdentifier: TimelineTableViewCell.identifier)
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        retrievePosts()
    }

    // MARK: - IBAction

    @IBAction func logoutPressed() {
        viewModel?.logout().subscribe(onCompleted: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }, onError: { [weak self] error in
            self?.displayAppErrorAlert(error: error)
        }).disposed(by: disposeBag)
    }

    @IBAction func newPostPressed() {
        guard let user = viewModel?.user else {
            fatalError("User not configured")
        }
        guard let newPostViewController = R.storyboard.timeline.newPostViewController() else { return }
        let viewModel = NewPostViewModel(user: user)
        newPostViewController.viewModel = viewModel
        navigationController?.present(newPostViewController, animated: true)
    }
}

// MARK: - Private methods

private extension TimelineViewController {

    func setupLocalization() {
        titleLabel.text = AppStrings.title.localized
        logoutButton.setTitle(AppStrings.logout.localized, for: .normal)
        newPostButton.setTitle(AppStrings.newPost.localized, for: .normal)
    }

    func retrievePosts() {
        viewModel?.retrieveAllPosts().asCompletable().subscribe(onCompleted: { [weak self] in
            self?.timelineTableView.reloadData()
            self?.startLiveUpdating()
        }, onError: { [weak self] error in
            self?.displayAppErrorAlert(error: error)
        }).disposed(by: disposeBag)
    }

    func startLiveUpdating() {
        viewModel?.newPosts.subscribe(onNext: { [weak self] (_, type, index) in
            let indexPath = IndexPath(item: index, section: 0)
            switch type {
            case .added:
                self?.timelineTableView.insertRows(at: [indexPath], with: .automatic)
            case .removed:
                self?.timelineTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }, onError: { [weak self] error in
            self?.displayAppErrorAlert(error: error)
        }).disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfPosts ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TimelineTableViewCell.identifier, for: indexPath) as? TimelineTableViewCell else { return UITableViewCell() }
        guard let post = viewModel?.postAt(index: indexPath.item) else { return cell }
        cell.configure(post: post)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel?.canErasePostAt(index: indexPath.item) ?? false
    }

    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            viewModel?.removePostAt(index: indexPath.item).subscribe().disposed(by: disposeBag)
        }
    }
}
