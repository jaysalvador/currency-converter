//
//  ConversionTests.swift
//  WestpacTests
//
//  Created by Jay Salvador on 12/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import XCTest
@testable import Currency

class ConversionTests: XCTestCase {
    
    func testAPI() {
        
        let currencies = self.getCurrencies()
        
        XCTAssertTrue(currencies.count > 0, "no currencies retrieved from the API")
    }
    
    func testConversionUSD() {
        
        let currencies = self.getMockCurrencies()
        
        let currencyUSD = currencies.first { $0.currencyCode == "USD" }
        
        let valueInUSD = 1000.0.convertTo(currency: currencyUSD)
        
        let priceString = valueInUSD.toPriceString(currency: currencyUSD)
        
        XCTAssertTrue(currencies.count > 0, "No currencies retrieved from the API")
        
        XCTAssert(currencyUSD != nil, "USD was not retrieved")
        
        XCTAssertEqual(valueInUSD, 623.6, "USD value not equal to 623.6")
        
        XCTAssertEqual(priceString, "$623.60", "NZD value not equal to $623.60")
    }
    
    func testConversionNZD() {
        
        let currencies = self.getMockCurrencies()
        
        let currencyNZD = currencies.first { $0.currencyCode == "NZD" }
        
        let valueInNZD = 1000.0.convertTo(currency: currencyNZD)
        
        let priceString = valueInNZD.toPriceString(currency: currencyNZD)
        
        let reconvertToAUD = valueInNZD.buy(currency: currencyNZD)
        
        XCTAssertTrue(currencies.count > 0, "No currencies retrieved from the API")
        
        XCTAssert(currencyNZD != nil, "NZD was not retrieved")
        
        XCTAssertEqual(valueInNZD, 996.5, "NZD value not equal to 996.5")
        
        XCTAssertEqual(priceString, "$996.50", "NZD value not equal to $996.50")
        
        XCTAssertEqual(reconvertToAUD, 1000, "NZD value not equal to 1000")
    }
    
    func testConversionPHP() {
        
        let currencies = self.getMockCurrencies()
        
        let currencyPHP = currencies.first { $0.currencyCode == "PHP" }
        
        let valueInPHP = 1000.0.convertTo(currency: currencyPHP)
        
        let priceString = valueInPHP.toPriceString(currency: currencyPHP)
        
        let reconvertToAUD = valueInPHP.buy(currency: currencyPHP)
        
        XCTAssertTrue(currencies.count > 0, "No currencies retrieved from the API")
        
        XCTAssert(currencyPHP != nil, "PHP was not retrieved")
        
        XCTAssertEqual(valueInPHP, 31691, "PHP value not equal to 31691")
        
        XCTAssertEqual(priceString, "₱31,691.00", "NZD value not equal to ₱31,691.00")
        
        XCTAssertEqual(reconvertToAUD, 1000, "PHP value not equal to 1000")
    }
    
    func getMockCurrencies() -> [Currency] {
        
        let expectation = self.expectation(description: "no data recieved")
        
        var currencies = [Currency]()
        
        DataHelper.getMockCurrencies { (response) in
            
            switch response {
                
            case .success(let _currencies):
                
                currencies = _currencies
                
            case .failure:
                
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        return currencies
    }
    
    func getCurrencies() -> [Currency] {
        
        let expectation = self.expectation(description: "no data recieved")
        
        var currencies = [Currency]()
        
        DataHelper.getCurrencies { (response) in
            
            switch response {
                
            case .success(let _currencies):
                
                currencies = _currencies
                
            case .failure:
                
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        return currencies
        
    }
}
