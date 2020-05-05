//
//  UserInfoVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 05.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    public var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavBar()
        configureNetwor()
    }
    
    private func configureNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismissDoneButton))
        doneButton.tintColor = .systemGreen
        title = username
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.titleView?.tintColor = .systemBackground
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNetwor() {
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGFAlertOnMain(title: "Something went wrong!", body: error.rawValue, titleButton: "OK")
            }
        }
    }
    
    @objc func handleDismissDoneButton() {
        dismiss(animated: true, completion: nil)
    }
}
