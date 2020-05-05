//
//  UIViewController+Ext.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 29.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    public func presentGFAlertOnMain(title: String, body: String, titleButton: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(titleMessage: title, bodyMessage: body, titleButton: titleButton)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    public func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.center = containerView.center
        activityIndicator.startAnimating()
    }
    
    public func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}
