//
//  Data+Ext.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 07.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "MMM yyyy"
        
        return dateFormatted.string(from: self)
    }
}
