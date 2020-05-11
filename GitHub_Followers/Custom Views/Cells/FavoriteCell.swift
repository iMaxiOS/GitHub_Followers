//
//  FavoriteCell.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 11.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static var cellId = "FavoriteCell"
    
    private let avatarImageView = GFImageView(frame: .zero)
    private let nameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26, weight: .bold)
    
    private let padding: CGFloat = 12
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    public func set(favorite: Follower) {
        nameLabel.text = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
    
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
