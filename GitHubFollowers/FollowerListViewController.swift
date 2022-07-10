//
//  FollowersListViewController.swift
//  GitHubFollowers
//
//  Created by Roberto Evangelista on 10/07/22.
//

import UIKit

final class FollowerListViewController: UIViewController {
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Methods
    private func configure() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
