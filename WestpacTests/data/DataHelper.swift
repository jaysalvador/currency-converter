//
//  DataHelper.swift
//  WestpacTests
//
//  Created by Jay Salvador on 13/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import Currency

typealias HelperCompletionClosure = ((Result<[Currency], Error>) -> Void)

class DataHelper {
    
    class func getCurrencies(completion: HelperCompletionClosure?) {
                
        let client = CurrencyClient()
        
        var currencies = [Currency]()
        
        client?.getCurrencies { (response) in
                          
            switch response {

            case .success(let result):

                if let _currencies = result.currencies, _currencies.count > 0 {

                    currencies = _currencies

                    currencies.insert(Currency.AUD, at: 0)
                }
                
                completion?(.success(currencies))

            case .failure(let error):
                
                completion?(.failure(error))
            }
        }
    }

    class func getMockCurrencies(completion: HelperCompletionClosure?) {

        let dataPath = Bundle(for: DataHelper.self).path(forResource: "data", ofType: "json") ?? ""
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: dataPath))
            
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .formatted(.yearMonthDay)
            
            let decoded = try decoder.decode(CurrencyClient.CurrencyResponse.self, from: data)
            
            completion?(.success(decoded.currencies ?? []))
        }
        catch {

            completion?(.failure(error))
        }
    }
}
