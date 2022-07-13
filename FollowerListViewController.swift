//
//  FollowersListViewController.swift
//  GitHubFollowers
//
//  Created by Roberto Evangelista on 10/07/22.
//

import UIKit

final class FollowerListViewController: UIViewController {
    
    // MARK: - Propeties
    let padding: CGFloat = 12
    var username: String!
    var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getFlollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Private Methods
    private func configure() {
        configureViewController()
        configureCollectionView()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(
            FollowerCollectionViewCell.self,
            forCellWithReuseIdentifier: FollowerCollectionViewCell.reusableID)
    }
    
    private func cellWidth() -> CGFloat {
        let viewWidth = view.bounds.width
        let spacing: CGFloat = 10
        let numberOfColumns: CGFloat = 3
        let availableWidth = viewWidth - (padding * 2) - (spacing * 2)
        return availableWidth / numberOfColumns
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let cellWidth = cellWidth()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)
        
        return flowLayout
    }
    
    private func getFlollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):
                print("Followers Count: \(followers.count)")
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
