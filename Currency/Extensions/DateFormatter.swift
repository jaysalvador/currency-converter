//
//  DateFormatter.swift
//  Currency
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public extension DateFormatter {
    
    /// returns a formatter for `yyyyMMdd`
    static let yearMonthDay: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter
    }()
    
    /// returns a formatter for ISO8601 `yyyyMMdd'T'HHmmss,SSSZZZZZ`
    static let iso8601WithComma: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss,SSSZZZZZ"
        
        return dateFormatter
    }()
    
    /// returns an API date format `HH:mm a dd MMM yyyy`
    static let lastUpdated: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "HH:mm a dd MMM yyyy"
        
        return dateFormatter
    }()
}
