//
//  Double.swift
//  Currency
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension Double {
    
    /// Converts the number to a currency formatted string based on which Curreny struct
    /// - Parameter currency: `Currency` struct
    public func toPriceString(currency: Currency?) -> String? {

        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        
        let blank = "-"
        
        guard let currency = currency else {
            
            return nil
        }
        
        guard let currencyCode = currency.currencyCode,
            let countryCode = currency.currencyCode?.toCountryCode else {
            
            formatter.currencySymbol = ""
            formatter.usesGroupingSeparator = false
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 4
            
            return formatter.string(from: NSNumber(value: self))
        }
        
        if currency.isGold {
            
            formatter.currencySymbol = ""
            
            let formattedString = currency.hasPrice ? formatter.string(from: NSNumber(value: self)) ?? blank : blank
            
            return "\(formattedString) oz"
        }
        else {

            formatter.usesGroupingSeparator = true
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "en_\(countryCode)")
            formatter.currencyCode = currencyCode
            
            if currency.hasPrice {

                return formatter.string(from: NSNumber(value: self))
            }
            else {

                return (formatter.currencySymbol ?? "") + " " + blank
            }
        }
    }
    
    /// Currency conversion, takes the number and computes for the sell value
    /// - Parameter currency: `Currency` struct
    public func convertTo(currency: Currency?) -> Double {
        
        return self * (currency?.sellTT ?? 0.0)
    }
}
