//
//  Currency.swift
//  Currency
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

/// Codable for Currency Object

public struct Currency: Codable {
    
    // MARK: - Attributes
    
    var currencyCode: String?
    var currencyName: String?
    var country: String?
    var buyTT: Double?
    var sellTT: Double?
    var buyTC: Double?
    var buyNotes: Double?
    var sellNotes: Double?
    var spotRateDate: Date?
    var effectiveDate: Date?
    var updateDate: Date?
    var lastUpdated: Date?

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

