//
//  SearchVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 27.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "gh-logo"))
    private let nameTextField = GFTextField()
    private let getButton = GFButton(bgColor: .systemGreen, title: "Get Followers")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configure()
        addConstraints()
        createDismissTapGestureRecognized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configure() {
        view.addSubview(imageView)
        view.addSubview(nameTextField)
        view.addSubview(getButton)
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createDismissTapGestureRecognized() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.5),
            
            nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            getButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            getButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            getButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            getButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
}
