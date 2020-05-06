//
//  UserInfoVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 05.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    private let headerView = UIView()
    private let itemMiddleView = UIView()
    private let itemBottomView = UIView()
    private var itemsView: [UIView] = []
    
    public var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        doneButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = doneButton
        
        layoutUI()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMain(title: "Something went wrong!", body: error.rawValue, titleButton: "Ok")
            }
        }
    }
    
    func layoutUI() {
        itemsView = [headerView, itemMiddleView, itemBottomView]
        
        for itemView in itemsView {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        itemBottomView.backgroundColor = .red
        itemMiddleView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemMiddleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemMiddleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemMiddleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemMiddleView.heightAnchor.constraint(equalToConstant: 140),
            
            itemBottomView.topAnchor.constraint(equalTo: itemMiddleView.bottomAnchor, constant: 20),
            itemBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemBottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemBottomView.heightAnchor.constraint(equalToConstant: 140)
            
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }
}
