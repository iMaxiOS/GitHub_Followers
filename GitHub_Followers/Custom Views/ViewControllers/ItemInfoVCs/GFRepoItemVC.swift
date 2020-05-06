//
//  GFRepoItemVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 06.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewLeft.set(items: .repos, count: user.publicRepos)
        itemInfoViewRight.set(items: .gists, count: user.publicGists)
        actionButton.customSet(bg: .systemPurple, title: "GitHub Profile")
    }
}
