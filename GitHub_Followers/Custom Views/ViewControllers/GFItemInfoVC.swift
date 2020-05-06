//
//  GFItemInfoVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 06.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    public let vStackView = UIStackView()
    public let itemInfoViewLeft = GFItemInfoView()
    public let itemInfoViewRight = GFItemInfoView()
    public let actionButton = GFButton()
    
    public var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureBackgroundView()
        configureStackView()
    }
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func layoutUI() {
        view.addSubview(vStackView)
        view.addSubview(actionButton)
        
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            vStackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureStackView() {
        vStackView.addArrangedSubview(itemInfoViewLeft)
        vStackView.addArrangedSubview(itemInfoViewRight)
        
        vStackView.distribution = .equalSpacing
        vStackView.axis = .horizontal
    }
}
