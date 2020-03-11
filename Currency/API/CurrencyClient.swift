//
//  CurrencyClient.swift
//  Currency
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public protocol CurrencyClientProtocol {
    
    func getCurrencies(onCompletion: HttpCompletionClosure<CurrencyClient.CurrencyResponse>?)
}

/// Client that handles requests to get the currency data
public class CurrencyClient: HttpClient, CurrencyClientProtocol {
    
    /// Gets all currencies from the API
    /// - Parameter onCompletion: completion closure with `Result` containing the array of currencies
    public func getCurrencies(onCompletion: HttpCompletionClosure<CurrencyClient.CurrencyResponse>?) {
        
        let endpoint = "/bin/getJsonRates.wbc.fx.json"
        
        self.request(
            CurrencyClient.CurrencyResponse.self,
            endpoint: endpoint,
            httpMethod: .get,
            headers: nil,
            onCompletion: onCompletion
        )
    }
}

extension CurrencyClient {
    
    /// Response type to decode currency data
    public struct CurrencyResponse: Decodable {
        
        public var currencies: [Currency]?
        
        enum RootKeys: String, CodingKey {
            
            case status
            case data
        }
        
        enum DataKeys: String, CodingKey {
            
            case brands = "Brands"
        }
        
        enum BrandsKeys: String, CodingKey {
            
            case wbc = "WBC"
        }
        
        enum WBCKeys: String, CodingKey {
            
            case brand = "Brand"
            case portfolios = "Portfolios"
        }
        
        enum PortfoliosKeys: String, CodingKey {
            
            case fx = "FX"
        }
        
        enum FXKeys: String, CodingKey {
            
            case portfolioId = "PortfolioId"
            case products = "Products"
        }
        
        enum ProductKeys: String, CodingKey {
            
            case productId = "ProductId"
            case rates = "Rates"
        }
        
        /// Handles custom dynamic keys
        private struct CustomCodingKeys: CodingKey {
            
            var stringValue: String
            
            var intValue: Int?
            
            init?(stringValue: String) {
                
                self.stringValue = stringValue
            }
            
            init?(intValue: Int) {
                
                return nil
            }
        }
        
        /// Decoded override to bind all currencies into an array
        /// - Parameter decoder: `Decoder ` object
        public init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: RootKeys.self)
            
            self.currencies = Array<Currency>()
            
            if let dataContainer = try? container.nestedContainer(keyedBy: DataKeys.self, forKey: .data),
                let brandsContainer = try? dataContainer.nestedContainer(keyedBy: BrandsKeys.self, forKey: .brands),
                let wbcContainer = try? brandsContainer.nestedContainer(keyedBy: WBCKeys.self, forKey: .wbc),
                let portfoliosContainer = try? wbcContainer.nestedContainer(keyedBy: PortfoliosKeys.self, forKey: .portfolios),
                let fxContainer = try? portfoliosContainer.nestedContainer(keyedBy: FXKeys.self, forKey: .fx),
                let productsContainer = try? fxContainer.nestedContainer(keyedBy: CustomCodingKeys.self, forKey: .products) {

                for key in productsContainer.allKeys {
                    
                    if let productContainer = try? productsContainer.nestedContainer(keyedBy: ProductKeys.self, forKey: key),
                        let innerProductContainer = try? productContainer.nestedContainer(keyedBy: CustomCodingKeys.self, forKey: .rates){
                        
                        for key in innerProductContainer.allKeys {
                         
                            let value = try innerProductContainer.decode(Currency.self, forKey: key)
                            
                            self.currencies?.append(value)
                        }
                    }
                }
            }
        }
    }
}

