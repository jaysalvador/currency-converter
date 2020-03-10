//
//  KeyedDecodingContainer.swift
//  Currency
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    
    func dateIfPresent(forKey key: KeyedDecodingContainer.Key) -> Date? {
        
        guard let string = try? self.decodeIfPresent(String.self, forKey: key) else {
            
            return nil
        }
        
        return string.toDate()
    }
    
    func doubleIfPresent(forKey key: KeyedDecodingContainer.Key) -> Double? {
        
        guard let string = try? self.decodeIfPresent(String.self, forKey: key) else {
            
            return nil
        }
        
        return Double(string)
    }
}
