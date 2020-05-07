//
//  String+Ext.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 07.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import Foundation

extension String {
    
    public func convertToDate() -> Date? {
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatted.locale = Locale(identifier: "en_US_POSIX")
        dateFormatted.timeZone = .current
        
        return dateFormatted.date(from: self)
    }
    
    public func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        
        return date .convertToMonthYearFormat()
    }
}
