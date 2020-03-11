//
//  Currency.swift
//  Currency
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import UIKit

/// Codable for Currency Object

public struct Currency: Codable {
    
    // MARK: - Attributes
    
    public var currencyCode: String?
    public var currencyName: String?
    public var country: String?
    public var buyTT: Double?
    public var sellTT: Double?
    public var buyTC: Double?
    public var buyNotes: Double?
    public var sellNotes: Double?
    public var spotRateDate: Date?
    public var effectiveDate: Date?
    public var updateDate: Date?
    public var lastUpdated: Date?

    // MARK: - Coding Keys
    
    // all fields are camel-cased
    enum CodingKeys: String, CodingKey {
        
        case currencyCode
        case currencyName
        case country
        case buyTT
        case sellTT
        case buyTC
        case buyNotes
        case sellNotes
        case spotRateDate = "SpotRate_Date_Fmt"
        case effectiveDate = "effectiveDate_Fmt"
        case updateDate = "updateDate_Fmt"
        case lastUpdated = "LASTUPDATED"
    }

    // decoder override to handle dates and numbers
    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.currencyCode = try container.decodeIfPresent(String.self, forKey: .currencyCode)
        self.currencyName = try container.decodeIfPresent(String.self, forKey: .currencyName)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.buyTT = container.doubleIfPresent(forKey: .buyTT)
        self.sellTT = container.doubleIfPresent(forKey: .sellTT)
        self.buyTC = container.doubleIfPresent(forKey: .buyTC)
        self.buyNotes = container.doubleIfPresent(forKey: .buyNotes)
        self.sellNotes = container.doubleIfPresent(forKey: .sellNotes)
        self.spotRateDate = container.dateIfPresent(forKey: .spotRateDate)
        self.effectiveDate = container.dateIfPresent(forKey: .effectiveDate)
        self.updateDate = container.dateIfPresent(forKey: .updateDate)
        self.lastUpdated = container.dateIfPresent(forKey: .lastUpdated)
    }
    
    /// Initialise a custom `Currency` struct
    public init (currencyCode: String?, currencyName: String?, country: String?, buyTT: Double?, sellTT: Double?, buyTC: Double?, buyNotes: Double?, sellNotes: Double?, spotRateDate: Date?, effectiveDate: Date?, updateDate: Date?, lastUpdated: Date?) {
        
        self.currencyCode = currencyCode
        self.currencyName = currencyName
        self.country = country
        self.buyTT = buyTT
        self.sellTT = sellTT
        self.buyTC = buyTC
        self.buyNotes = buyNotes
        self.sellNotes = sellNotes
        self.spotRateDate = spotRateDate
        self.effectiveDate = effectiveDate
        self.updateDate = updateDate
        self.lastUpdated = lastUpdated

    }
}

extension Currency {
    
    /// a static constant for AUD with empty rate values
    public static let AUD: Currency = {
        
        let AUD = Currency(
            currencyCode: "AUD",
            currencyName: "Dollars",
            country: "Australia",
            buyTT: 1.00,
            sellTT: 1.00,
            buyTC: 1.00,
            buyNotes: 1.00,
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
    
    public var hasPrice: Bool {
        
        return self.sellTT != nil
    }
    
    /// converts a `Currency` struct to AUD
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
        
        return self.formatter.currencySymbol
    }
}

extension Currency: Equatable {
    
    // add equatable to compare Currency objects
    
    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        
        guard let lhsCurrencyCode = lhs.currencyCode, let rhsCurrencyCode = rhs.currencyCode else {
            
            return false
        }
        
        return lhsCurrencyCode == rhsCurrencyCode
    }
}

