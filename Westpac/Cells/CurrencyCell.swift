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
        
        return self
    }
}
