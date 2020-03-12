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
    
    func prepare(currency: Currency?) -> UICollectionViewCell {
        
        self.detailsLabel?.text = currency?.details
        
        return self
    }
    
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
