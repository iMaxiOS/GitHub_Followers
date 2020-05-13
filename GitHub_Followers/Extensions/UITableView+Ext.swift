//
//  UITableView+Ext.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 13.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func reloadDataOnMainThreed() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    public func removeSeparator() {
        tableFooterView = UIView(frame: .zero)
    }
}
