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

    func prepare(price: Double, currency: Currency?) -> UICollectionViewCell {
        
        let convertedAmount: Double = price * (currency?.sellTT ?? 0.0)
                
        return self.prepare(
            price: String(format: "%.2f", convertedAmount),
            currency: currency?.currencyCode,
            image: UIImage(named: "\(currency?.currencyCode ?? "")")
        )
    }
    
    func prepare(price: String?, currency: String?, image: UIImage?) -> UICollectionViewCell {
        
        self.priceLabel?.text = price
        
        self.currencyLabel?.text = currency
        
        self.currencyImageView?.image = image
        
        return self
    }
}
