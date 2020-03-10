//
//  DateFormatter.swift
//  Currency
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let yearMonthDay: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter
    }()
    
    static let iso8601WithComma: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss,SSSZZZZZ"
        
        return dateFormatter
    }()
    
    static let lastUpdated: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "HH:mm a dd MMM yyyy"
        
        return dateFormatter
    }()
}
