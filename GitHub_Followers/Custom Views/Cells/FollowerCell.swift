//
//  FollowerCell.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 01.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static var cellId = "FollowerCell"
    
    private let avatarImageView = UIImageView()
    private let nameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16, weight: .heavy)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
