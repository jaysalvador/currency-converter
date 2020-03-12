//
//  CurrencyDetailViewModel.swift
//  Westpac
//
//  Created by Jay Salvador on 12/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import Currency

protocol CurrencyDetailViewModelProtocol {
    
    var source: Currency? { get }
    
    var destination: Currency? { get }
    
    var value: Double? { get set }
}

class CurrencyDetailViewModel: CurrencyDetailViewModelProtocol {
    
    var value: Double?
    
    private(set) var source: Currency?
    
    private(set) var destination: Currency?
    
    init(value: Double?, source: Currency?, destination: Currency?) {
        
        self.value = value
        
        self.source = source
        
        self.destination = destination
    }
}
