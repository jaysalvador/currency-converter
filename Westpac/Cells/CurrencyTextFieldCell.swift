//
//  CurrencyTextFieldCell.swift
//  Westpac
//
//  Created by Jay Salvador on 12/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Currency

typealias TextInputChangedClosure = ((String?) -> Void)

class CurrencyTextFieldCell: UICollectionViewCell, UITextFieldDelegate {

    @IBOutlet
    private var containerView: UIView?
    
    @IBOutlet
    private var dividerView: UIView?
    
    @IBOutlet
    private var imageView: UIImageView?
    
    @IBOutlet
    private var currencyLabel: UILabel?
    
    @IBOutlet
    private var textField: UITextField?
    
    private var onTextChanged: TextInputChangedClosure?
    
    func prepare(
        value: Double?,
        currency: Currency?,
        onTextChanged _onTextChanged: TextInputChangedClosure?
    ) -> UICollectionViewCell {
        
        let priceString = String(format: "%.2f", value ?? 0.0)
        
        self.textField?.text = priceString
        
        self.imageView?.image = currency?.image
        
        self.currencyLabel?.text = currency?.currencySymbol
        
        self.onTextChanged = _onTextChanged
        
        return self
    }
    
    func update(value: Double?) {
        
        self.textField?.text = String(format: "%.2f", value ?? 0.0)
    }
    
    // MARK: - Actions
    
    @IBAction
    private func textFieldEditingChanged(_ textField: UITextField) {
        
        self.onTextChanged?(textField.text)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            
            return true
        }
        
        return Double(text + string) != nil
    }
}
