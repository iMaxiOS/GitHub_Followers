//
//  FavoritesListVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 27.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        PersistenManager.retrieveFolower { result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
