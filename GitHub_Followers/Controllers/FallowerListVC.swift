//
//  FallowerListVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 28.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FallowerListVC: GFDataLoadingVC {
    
    private var followers: [Follower] = []
    private var filteredFollower: [Follower] = []
    private var page = 1
    private var hasMoreFollower = true
    private var isSearching = false
    private var isLoadingMoreFollowers = false
    
    enum Section {
        case main
    }
    
    public var username: String!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureSearchController()
        configureViewController()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.title = username
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColums())
        view.addSubviews(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.cellId)
        
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddButton))
    }
    
    private func createThreeColums() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumSpacing: CGFloat = 10
        let sizeCell = width - (padding * 2) - (minimumSpacing * 2)
        let itemSize = sizeCell / 3
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = .init(width: itemSize, height: itemSize + 40)
        
        return flowlayout
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a user name"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.cellId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(on follower: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(follower)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
        }
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollower = false
                }
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty {
                    let message = "This user doesn`t have any followers. Let`s go follower them 🙂"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(message: message, in: self.view)
                    }
                    return
                }
                
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMain(title: "user name not found", body: error.rawValue, titleButton: "OK")
            }
            
            self.isLoadingMoreFollowers = false
        }
    }
    
    @objc func handleAddButton() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
            case .failure(let error):
                self.presentGFAlertOnMain(title: "Something went wrong", body: error.rawValue, titleButton: "OK")
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let err = error else {
                self.presentGFAlertOnMain(title: "Success!", body: "You have successfully favorited this user 🎉", titleButton: "Uhhhy!")
                return
            }
        
            self.presentGFAlertOnMain(title: "Something went wrong", body: err.rawValue, titleButton: "OK")
            
        }
    }
}

extension FallowerListVC: UICollectionViewDelegate {
    
    //so that there is no request to the server you need to call .. guard hasMoreFollower else { return }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            guard hasMoreFollower, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activityArray = isSearching ? filteredFollower : followers
        let follower = activityArray[indexPath.item]
        
        let userInfoVC = UserInfoVC()
        userInfoVC.username = follower.login
        userInfoVC.delegate = self
        let navController = UINavigationController(rootViewController: userInfoVC)
        present(navController, animated: true, completion: nil)
    }
}

extension FallowerListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollower.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        filteredFollower = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollower)
    }
}

extension FallowerListVC: FollowerListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollower.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
