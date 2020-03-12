//
//  CurrencyCell.swift
//  Westpac
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Currency

class CurrencyCell: UICollectionViewCell {

    @IBOutlet
    private var priceLabel: UILabel?
    
    @IBOutlet
    private var currencyLabel: UILabel?
    
    @IBOutlet
    private var currencyImageView: UIImageView?
    
    @IBOutlet
    private var borderView: UIView?
    
    /// Prepares the cell based on price and currency selected
    /// - Parameter price: monetary amount
    /// - Parameter currency: `Currency` object
    func prepare(price: Double, currency: Currency?) -> UICollectionViewCell {
                    
        return self.prepare(
            price: price.convertTo(currency: currency).toPriceString(currency: currency),
            currency: currency?.currencyCode,
            image: currency?.image
        )
    }
    
    /// Generic setup for this cell
    /// - Parameter price: sets the price label
    /// - Parameter currency: sets the currency label
    /// - Parameter image: sets the Image View
    func prepare(price: String?, currency: String?, image: UIImage?) -> UICollectionViewCell {
        
        self.priceLabel?.text = price
        
        self.currencyLabel?.text = currency
        
        self.currencyImageView?.image = image
        
        self.applyTheme()
        
        return self
    }
    
    private func applyTheme() {
        
        let theme = AppDelegate.shared?.theme ?? .standard
        
        switch theme {
        case .red:
            
            self.priceLabel?.textColor = .red
            
            self.currencyLabel?.textColor = .red
            
            self.borderView?.backgroundColor = .borderRed
            
        default:
        
            self.priceLabel?.textColor = .darkGray
        
            self.currencyLabel?.textColor = .darkGray
            
            self.borderView?.backgroundColor = .borderGray
        }
    }
}
