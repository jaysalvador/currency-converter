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
    
    @IBOutlet
    private var borderView: UIView?
    
    /// Prepares the cell based on currency
    /// - Parameter currency: `Currency` object 
    /// - Parameter isSelected: if `true`, will highlight the cell background
    func prepare(currency: Currency?, isSelected: Bool) -> UICollectionViewCell{
        
        self.accessibilityIdentifier = currency?.currencyCode
     
        return prepare(currency: currency?.description, image: currency?.image, isSelected: isSelected)
    }
    
    /// Generic setup for this cell
    /// - Parameter currency: sets the currency label
    /// - Parameter image: sets the Image View
    /// - Parameter isSelected: if `true`, will highlight the cell background
    func prepare(currency: String?, image: UIImage?, isSelected: Bool) -> UICollectionViewCell {
        
        self.backgroundColor = .clear
        
        self.currencyLabel?.text = currency
        
        self.imageView?.image = image
        
        self.applyTheme(isSelected)
        
        return self
    }
    
    /// Change the cell's UI based on  the defined`Theme`
    private func applyTheme(_ isSelected: Bool) {
        
        let theme = AppDelegate.shared?.theme ?? .standard
        
        switch theme {
        case .red:
        
            if isSelected {
        
                self.backgroundColor = .borderRed
            }
        
            self.currencyLabel?.textColor = .red
            
            self.borderView?.backgroundColor = .borderRed
            
        default:
        
            if isSelected {
        
                self.backgroundColor = .lightGray
            }
        
            self.currencyLabel?.textColor = .darkGray
                    
            self.borderView?.backgroundColor = .borderGray
        }
    }
}
