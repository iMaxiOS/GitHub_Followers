//
//  GFFollowerItemVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 06.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//


import UIKit

protocol GFFollowerItemVCDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewLeft.set(items: .followers, count: user.followers)
        itemInfoViewRight.set(items: .following, count: user.following)
        actionButton.customSet(bg: .systemGreen, title: "Get Followers")
    }
    
    override func handleActionButton() {
        delegate.didTapGetFollowers(for: user)
    }
}
