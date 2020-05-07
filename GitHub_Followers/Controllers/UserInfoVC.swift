//
//  UserInfoVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 05.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    private var itemsView: [UIView] = []
    private let headerView = UIView()
    private let itemMiddleView = UIView()
    private let itemBottomView = UIView()
    private let dateLabel = GFBodyLabel(textAlignment: .center, fontSize: 16, weight: .black)
    
    
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
                    self.add(childVC: GFRepoItemVC(user: user), to: self.itemMiddleView)
                    self.add(childVC: GFFollowerItemVC(user: user), to: self.itemBottomView)
                    self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
                }
            case .failure(let error):
                self.presentGFAlertOnMain(title: "Something went wrong!", body: error.rawValue, titleButton: "Ok")
            }
        }
    }
    
    func layoutUI() {
        itemsView = [headerView, itemMiddleView, itemBottomView, dateLabel]
        
        for itemView in itemsView {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemMiddleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemMiddleView.heightAnchor.constraint(equalToConstant: 140),
            
            itemBottomView.topAnchor.constraint(equalTo: itemMiddleView.bottomAnchor, constant: 20),
            itemBottomView.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemBottomView.bottomAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
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
