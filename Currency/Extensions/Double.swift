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

        let blank = "-"
        
        guard let currency = currency else {
            
            return nil
        }
        
        if currency.isGold {
            
            let formattedString = currency.hasPrice ? currency.formatter.string(from: NSNumber(value: self)) ?? blank : blank
            
            return "\(formattedString) oz"
        }
        else {
            
            if currency.hasPrice {

                return currency.formatter.string(from: NSNumber(value: self))
            }
            else {

                return currency.currencySymbol + " " + blank
            }
        }
    }
    
    /// Currency conversion, takes the number and computes for the sell value
    /// - Parameter currency: `Currency` struct
    public func convertTo(currency: Currency?) -> Double {
        
        return self * (currency?.sellTT ?? 0.0)
    }
    
    /// Currency conversion to revert back the amount
    /// - Parameter currency: `Currency` used in conversion
    public func convertBack(currency: Currency?) -> Double {
        
        guard let sellTT = currency?.sellTT, sellTT != 0 else {
            
            return 0
        }
        
        return self / sellTT
    }
}
