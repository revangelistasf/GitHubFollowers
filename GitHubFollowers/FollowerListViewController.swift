//
//  FollowersListViewController.swift
//  GitHubFollowers
//
//  Created by Roberto Evangelista on 10/07/22.
//

import UIKit

final class FollowerListViewController: UIViewController {
    
    // MARK: - Propeties
    var username: String!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Private Methods
    private func configure() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
