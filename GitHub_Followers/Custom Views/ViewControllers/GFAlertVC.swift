//
//  GFAlertVC.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 29.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {
    
    private let containerView = UIView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20, weight: .black)
    private let bodyLabel = GFBodyLabel(textAlignment: .center, fontSize: 16, weight: .medium)
    private let okButton = GFButton(bgColor: .systemPink, title: "Ok")
    
    var titleMessage: String?
    var bodyMessage: String?
    var titleButton: String?
    
    init(titleMessage: String, bodyMessage: String, titleButton: String?) {
        super.init(nibName: nil, bundle: nil)
        self.titleMessage = titleMessage
        self.bodyMessage = bodyMessage
        self.titleButton = titleButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 16
        
        containerView.addSubview(titleLabel)
        titleLabel.text = titleMessage ?? "Something went wrong"
        
        containerView.addSubview(bodyLabel)
        bodyLabel.text = bodyMessage ?? "Unable to complite request"
        bodyLabel.numberOfLines = 4
        
        containerView.addSubview(okButton)
        okButton.setTitle(titleButton ?? "Ok", for: .normal)
        okButton.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: view.frame.width - 50),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -12),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            okButton.heightAnchor.constraint(equalToConstant: 46),
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func handleButton() {
        dismiss(animated: true, completion: nil)
    }
}
