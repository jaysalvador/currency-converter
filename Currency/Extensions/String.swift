//
//  String.swift
//  Currency
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension String {
    
    /// Converts the currency code string to country code
    public var toCountryCode: String? {
        
        guard self != "", self.count >= 2 else {
            
            return nil
        }
        
        if self.prefix(1) == "X" {

            return String(self.suffix(2))
        }
        else {
         
            return String(self.prefix(2))
        }
    }
    
    /// Returns the date value of the String based on the formats determined from the API
    public func toDate() -> Date? {
        
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
