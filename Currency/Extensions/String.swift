//
//  String.swift
//  Currency
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public extension String {
    
    /// Returns the date value of the String based on the formats determined from the API
    func toDate() -> Date? {
        
        if let yearMonthDayDate = DateFormatter.yearMonthDay.date(from: self) {
            
            return yearMonthDayDate
        }
        else if let fullIsoDate = DateFormatter.iso8601WithComma.date(from: self) {
            
            return fullIsoDate
        }
        else if let altIsoDate = DateFormatter.lastUpdated.date(from: self) {
            
            return altIsoDate
        }
        
        return nil
    }
}
