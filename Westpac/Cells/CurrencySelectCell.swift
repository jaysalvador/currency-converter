//
//  CurrencySelectCell.swift
//  Westpac
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Currency

class CurrencySelectCell: UICollectionViewCell {

    @IBOutlet
    private var imageView: UIImageView?
    
    @IBOutlet
    private var currencyLabel: UILabel?
    
    func prepare(currency: Currency?, isSelected: Bool) -> UICollectionViewCell{
     
        return prepare(currency: currency?.description, image: currency?.image, isSelected: isSelected)
    }
    
    func prepare(currency: String?, image: UIImage?, isSelected: Bool) -> UICollectionViewCell {
        
        self.backgroundColor = .clear
        
        if isSelected {
        
            self.backgroundColor = .lightGray
        }
        
        self.currencyLabel?.text = currency
        
        self.imageView?.image = image
        
        return self
    }
}
