//
//  UIView+Ext.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 12.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

extension UIView {
    
    public func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    public func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
