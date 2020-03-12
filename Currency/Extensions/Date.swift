//
//  Date.swift
//  Currency
//
//  Created by Jay Salvador on 12/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension Date {
    
    public func toString(using dateFormatter: DateFormatter?, in timezone: String? = nil) -> String? {

        dateFormatter?.timeZone = TimeZone(identifier: timezone ?? TimeZone.current.identifier)

        return dateFormatter?.string(from: self)
    }
}
