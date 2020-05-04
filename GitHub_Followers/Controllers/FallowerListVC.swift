//
//  FallowerListVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 28.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class FallowerListVC: UIViewController {
    
    private var follower: [Follower] = []
    private var page = 1
    private var hasMoreFollower = true
    
    enum Section {
        case main
    }
    
    public var userName: String!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(username: userName, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColums())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.cellId)
        
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.cellId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(follower)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
        }
    }
    
    private func getFollowers(username: String, page: Int) {
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollower = false }
                self.follower.append(contentsOf: followers)
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMain(title: "user name not found", body: error.rawValue, titleButton: "OK")
            }
        }
    }
}

extension FallowerListVC: UICollectionViewDelegate {
    
    //so that there is no request to the server you need to call .. guard hasMoreFollower else { return }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            guard hasMoreFollower else { return }
            page += 1
            getFollowers(username: userName, page: page)
        }
    }
}
