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
    enum CodingKeys: String, CodingKey, CaseIterable {
        
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

