//
//  Currency+Helpers.swift
//  Currency
//
//  Created by Jay Salvador on 12/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import UIKit

extension Currency {
    
    /// a static constant for AUD with default rate values
    public static let AUD: Currency = {
        
        let AUD = Currency(
            currencyCode: "AUD",
            currencyName: "Dollars",
            country: "Australia",
            buyTT: 1.00,
            sellTT: 1.00,
            buyTC: nil,
            buyNotes: nil,
            sellNotes: nil,
            spotRateDate: nil,
            effectiveDate: nil,
            updateDate: nil,
            lastUpdated: nil
        )
        
        return AUD
    }()
    
    /// checks if the `Currency` is AUD
    public var isAUD: Bool {
        
        return self.currencyCode?.uppercased() == "AUD"
    }
    
    /// checks if the `Currency` is Gold
    public var isGold: Bool {
        
        return self.currencyCode?.uppercased() == "XAU"
    }
    
    /// checks if the currency has a price that can be sold
    public var hasPrice: Bool {
        
        return self.sellTT != nil
    }
    
    /// converts a `Currency` struct to AUD
    /// flips the buy/sell values for AUD
    public var toAUD: Currency {
        
        var AUD = Currency.AUD
        
        AUD.sellTT = nil
        AUD.buyTT = nil
        
        if let buyTT = self.buyTT, buyTT > 0 {
            
            AUD.sellTT = 1 / buyTT
        }
        if let sellTT = self.sellTT, sellTT > 0 {
            
            AUD.buyTT = 1 / sellTT
        }
        
        AUD.spotRateDate = self.spotRateDate
        AUD.effectiveDate = self.effectiveDate
        AUD.updateDate = self.updateDate
        AUD.lastUpdated = self.lastUpdated
        
        return AUD
    }
    
    /// returns a description of the currency, country and currency symbol
    public var description: String {
        
        var description: String = ""
        
        if let country = self.country {
        
            description = country
        }
        
        if let currency = self.currencyName, !self.isGold {
             
            description += (description != "" ? " " : "") + currency
        }
        
        description += " (\(self.currencySymbol))"
        
        return description
    }
    
    /// returns the image of the currency country flag
    public var image: UIImage? {
        
        return UIImage(named: "\(self.currencyCode ?? "")")
    }
    
    public var formatter: NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        
        guard let currencyCode = self.currencyCode,
            let countryCode = self.currencyCode?.toCountryCode else {
            
            formatter.currencySymbol = ""
            formatter.usesGroupingSeparator = false
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 4
            
            return formatter
        }
        
        if self.isGold {
            
            formatter.currencySymbol = ""
            
            return formatter
        }
        else {

            formatter.usesGroupingSeparator = true
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "en_\(countryCode)")
            formatter.currencyCode = currencyCode
            
            return formatter
        }
    }
    
    public var currencySymbol: String {
        
        return self.isGold ? "oz" : self.formatter.currencySymbol
    }
    
    public var details: String {
        
        var details = ""
        
        let buyTT = self.buyTT == nil ? "N/A" : String(self.buyTT ?? 0)
        let sellTT = self.sellTT == nil ? "N/A" : String(self.sellTT ?? 0)
        let buyTC = self.buyTC == nil ? "N/A" : String(self.buyTC ?? 0)
        let buyNotes = self.buyNotes == nil ? "N/A" : String(self.buyNotes ?? 0)
        let sellNotes = self.sellNotes == nil ? "N/A" : String(self.sellNotes ?? 0)
        let spotRateDate = self.spotRateDate?.toString(using: .displayDate) ?? "N/A"
        let effectiveDate = self.effectiveDate?.toString(using: .displayDate) ?? "N/A"
        let updateDate = self.updateDate?.toString(using: .displayDate) ?? "N/A"
        let lastUpdated = self.lastUpdated?.toString(using: .displayDate) ?? "N/A"
        
        details.append("Currency Code: \(self.currencyCode ?? "")\n")
        details.append("Currency Name: \(self.currencyName ?? "")\n")
        
        if !self.isGold {
        
            details.append("Country: \(self.country ?? "")\n")
        }
        
        details.append("Buy TT: \(buyTT)\n")
        details.append("Sell TT: \(sellTT)\n")
        details.append("Buy TC: \(buyTC)\n")
        details.append("Buy Notes: \(buyNotes)\n")
        details.append("Sell Notes: \(sellNotes)\n")
        details.append("Spot Rate Date: \(spotRateDate)\n")
        details.append("Effective Date: \(effectiveDate)\n")
        details.append("Update Date: \(updateDate)\n")
        details.append("Last Updated: \(lastUpdated)\n")
        
        return details
    }
}
