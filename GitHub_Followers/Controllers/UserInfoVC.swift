//
//  UserInfoVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 05.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    private let scrollView = UIScrollView()
    private let conteinerView = UIView()
    
    private var itemsView: [UIView] = []
    private let headerView = UIView()
    private let itemMiddleView = UIView()
    private let itemBottomView = UIView()
    private let dateLabel = GFBodyLabel(textAlignment: .center, fontSize: 16, weight: .black)
    
    public var username: String!
    weak var delegate: FollowerListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUser()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        doneButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUser() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.conigureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMain(title: "Something went wrong!", body: error.rawValue, titleButton: "Ok")
            }
        }
    }
    
    private func conigureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemMiddleView)
        self.add(childVC: followerItemVC, to: self.itemBottomView)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    private func configureScrollView() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(conteinerView)
        scrollView.pinToEdges(of: view)
        conteinerView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            conteinerView.heightAnchor.constraint(equalToConstant: 600),
            conteinerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func layoutUI() {
        itemsView = [headerView, itemMiddleView, itemBottomView, dateLabel]
        
        for itemView in itemsView {
            conteinerView.addSubviews(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20),
                itemView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemMiddleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemMiddleView.heightAnchor.constraint(equalToConstant: 140),
            
            itemBottomView.topAnchor.constraint(equalTo: itemMiddleView.bottomAnchor, constant: 20),
            itemBottomView.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemBottomView.bottomAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: GFRepoItemVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMain(title: "Invalid URL", body: "The url attahed to this user is invalid", titleButton: "Ok")
            return
        }
        
        presentSafaryVC(with: url)
    }
}

extension UserInfoVC: GFFollowerItemVCDelegate {
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMain(title: "No followers", body: "This user has no followers. What a shame 😔", titleButton: "So sad")
            return
        }

        delegate.didRequestFollowers(for: user.login)
        dismssVC()
    }
}
