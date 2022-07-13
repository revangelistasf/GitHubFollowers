//
//  FollowersListViewController.swift
//  GitHubFollowers
//
//  Created by Roberto Evangelista on 10/07/22.
//

import UIKit

final class FollowerListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    // MARK: - Propeties
    let padding: CGFloat = 12
    var username: String!
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getFlollowers()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reusableID)
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
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                self.followers = followers
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
