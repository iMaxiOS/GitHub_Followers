//
//  GFAlertContainerView.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 12.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.borderWidth = 2
        layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
