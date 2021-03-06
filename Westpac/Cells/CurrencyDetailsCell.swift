//
//  CurrencyDetailsCell.swift
//  Westpac
//
//  Created by Jay Salvador on 12/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Currency

class CurrencyDetailsCell: UICollectionViewCell {

    @IBOutlet
    private var detailsLabel: UILabel?
    
    /// Prepares the cell based on currency
    /// - Parameter currency: `Currency` object
    func prepare(currency: Currency?) -> UICollectionViewCell {
        
        self.accessibilityIdentifier = currency?.currencyCode
        
        self.detailsLabel?.text = currency?.details
        
        self.applyTheme()
        
        return self
    }
    
    /// Change the cell's UI based on  the defined`Theme`
    private func applyTheme() {
        
        let theme = AppDelegate.shared?.theme ?? .standard
        
        switch theme {
        case .red:
            
            self.detailsLabel?.textColor = .red
            
        default:
                
            self.detailsLabel?.textColor = .darkGray
        }
    }
    
    /// Computes the size of the cell based on the currency description
    /// - Parameter width: the cell's maximum width
    /// - Parameter currency: `Currency` object 
    class func size(givenWidth width: CGFloat, currency: Currency?) -> CGSize {
        
        guard let currency = currency else {
            
            return CGSize(width: width, height: 64.0)
        }
        
        let rect = currency.details.boundingRect(
            with: CGSize(
                width: width - 40.0,
                height: CGFloat.greatestFiniteMagnitude),
            options: [
                .usesLineFragmentOrigin,
                .usesFontLeading,
                .truncatesLastVisibleLine
            ],
            font: .circularBold(ofSize: 16.0)
        )
        
        return CGSize(width: width, height: rect.height + 30)
    }
}
