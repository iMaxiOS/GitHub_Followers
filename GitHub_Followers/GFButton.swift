//
//  GFButton.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 27.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        titleLabel?.textColor = .systemBackground
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(bgColor: UIColor, title: String) {
        super.init(frame: .zero)
        backgroundColor = bgColor
        setTitle(title, for: .normal)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
