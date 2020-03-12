//
//  Currency+Equatable.swift
//  Currency
//
//  Created by Jay Salvador on 12/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension Currency: Equatable {
    
    // add equatable to compare Currency objects
    
    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        
        guard let lhsCurrencyCode = lhs.currencyCode, let rhsCurrencyCode = rhs.currencyCode else {
            
            return false
        }
        
        return lhsCurrencyCode == rhsCurrencyCode
    }
}
