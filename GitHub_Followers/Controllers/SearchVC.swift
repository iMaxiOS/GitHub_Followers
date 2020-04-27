//
//  SearchVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 27.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}
