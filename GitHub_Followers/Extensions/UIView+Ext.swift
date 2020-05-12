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
}
