//
//  UIViewController+Ext.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 29.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func presentGFAlertOnMain(title: String, body: String, titleButton: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(titleMessage: title, bodyMessage: body, titleButton: titleButton)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
