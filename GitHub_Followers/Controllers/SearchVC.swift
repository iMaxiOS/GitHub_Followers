//
//  SearchVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 27.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class SearchVC: GFDataLoadingVC {
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "gh-logo"))
    private let nameTextField = GFTextField()
    private let getButton = GFButton(bgColor: .systemGreen, title: "Get Followers")
    
    private var topImageLogoConstraints: NSLayoutConstraint!
    
    private var isUsernameEntered: Bool {
        return nameTextField.text?.isEmpty ?? false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configure()
        configureGetButton()
        addConstraints()
        createDismissTapGestureRecognized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configure() {
        view.addSubviews(imageView, nameTextField, getButton)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.delegate = self
    }
    
    private func createDismissTapGestureRecognized() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func configureGetButton() {
        getButton.addTarget(self, action: #selector(handlePush), for: .touchUpInside)
    }
    
    @objc func handlePush() {
        if isUsernameEntered {
            presentGFAlertOnMain(title: "Empty Username", body: "Please enter a username. We need to know who look for us 😀.", titleButton: "OK")
            return
        }
        
        nameTextField.resignFirstResponder()
        
        let followerListVC = FallowerListVC(username: nameTextField.text ?? "Default")
        nameTextField.resignFirstResponder()
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    private func addConstraints() {
        
        let topLogoConstraints: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 50 : 80

        topImageLogoConstraints = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topLogoConstraints)
        topImageLogoConstraints.isActive = true
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.5),
            
            nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            getButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            getButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            getButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handlePush()
        return true
    }
}
