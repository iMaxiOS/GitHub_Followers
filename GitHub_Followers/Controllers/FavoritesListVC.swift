//
//  FavoritesListVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 27.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class FavoritesListVC: GFDataLoadingVC {
    
    private var favoriteTableView = UITableView()
    private var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavBar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorite()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubviews(favoriteTableView)
        favoriteTableView.frame = view.bounds
        favoriteTableView.removeSeparator()
        favoriteTableView.rowHeight = 80
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.cellId)
    }
    
    private func getFavorite() {
        PersistenManager.retrieveFolower { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                self.presentGFAlertOnMain(title: "Something went wrong", body: error.rawValue, titleButton: "OK")
            }
        }
    }
    
    private func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            self.showEmptyStateView(message: "No Favorites?\nAdd one on the follower screen", in: self.view)
        } else {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
                self.view.bringSubviewToFront(self.favoriteTableView)
            }
        }
    }
}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.cellId, for: indexPath) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FallowerListVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let err = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentGFAlertOnMain(title: "Unable to remove", body: err.rawValue, titleButton: "OK")
        }
    }
}
