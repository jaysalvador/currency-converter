//
//  CurrencyViewModel.swift
//  Westpac
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import Currency

typealias ViewModelCallback = (() -> Void)

protocol CurrencyViewModelProtocol {
    
    // MARK: - Data
    
    var currencies: [Currency]? { get }
    
    var selectedCurrency: Currency { get set }
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback? { get set }
    
    var onError: ViewModelCallback? { get set }
    
    // MARK: - Functions
    
    func getCurrencies()
}

class CurrencyViewModel: CurrencyViewModelProtocol {
    
    // MARK: - Dependencies
    
    private var currencyClient: CurrencyClientProtocol?
    
    // MARK: - Data
    
    var selectedCurrency: Currency = Currency.AUD
    
    private(set) var currencies: [Currency]?
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback?
    
    var onError: ViewModelCallback?
    
    // MARK: - Init
    
    convenience init() {
        
        self.init(currencyClient: CurrencyClient())
    }
    
    init(currencyClient _currencyClient: CurrencyClientProtocol?) {
        
        self.currencyClient = _currencyClient
    }
    
    // MARK: - Functions
    
    /// Gets all the currencies from the API using the `Currency` library
    func getCurrencies() {
        
        self.currencyClient?.getCurrencies { [weak self] (response) in
                   
            switch response {

            case .success(let result):

                self?.currencies = result.currencies
                
                self?.currencies?.insert(Currency.AUD, at: 0)
                
                self?.onUpdated?()

            case .failure:

                self?.onError?()
            }
        }
    }
}
