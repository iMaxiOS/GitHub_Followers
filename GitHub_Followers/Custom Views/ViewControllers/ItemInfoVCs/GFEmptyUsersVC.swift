//
//  GFEmptyUsersVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 05.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class GFEmptyUsersVC: UIView {
    
    private let logoImageView = UIImageView()
    private let textLabel = GFTitleLabel(textAlignment: .center, fontSize: 28, weight: .black)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(message: String) {
        super.init(frame: .zero)
        textLabel.text = message
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(textLabel)
        addSubview(logoImageView)
        
        textLabel.textColor = .secondaryLabel
        textLabel.numberOfLines = 0
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        let centerYLabelConstraints = textLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: labelCenterYConstant)
        centerYLabelConstraints.isActive = true
        
        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        let logoImageViewBottomConstraints = logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: logoBottomConstant)
        logoImageViewBottomConstraints.isActive = true
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 200),
        ])
    }

}
