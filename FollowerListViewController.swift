//
//  FollowersListViewController.swift
//  GitHubFollowers
//
//  Created by Roberto Evangelista on 10/07/22.
//

import UIKit

final class FollowerListViewController: UIViewController {
    enum Section { case main }
    
    // MARK: - Propeties
    var username: String!
    var followers: [Follower] = []
    var page = 1
    var followersPerPage = 100
    var hasMoreFolllowers = true
    
    // MARK: - Views
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getFlollowers(username: username, page: page)
        configureDataSource()
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
        collectionView = UICollectionView(
            frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reusableID)
    }
    
    private func getFlollowers(username: String, page: Int) {
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                if followers.count < self.followersPerPage { self.hasMoreFolllowers = false }
                
                self.followers.append(contentsOf: followers)
                self.updateCollectionViewData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowerCell.reusableID, for: indexPath) as! FollowerCell
                cell.set(follower: follower)
                return cell
        })
    }
    
    private func updateCollectionViewData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension FollowerListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFolllowers else { return }
            page += 1
            getFlollowers(username: username, page: page)
        }
    }
}
