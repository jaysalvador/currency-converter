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
        
        self.accessibilityIdentifier = currency?.currencyCode
        
        let priceString = String(format: "%.2f", value ?? 0.0)
        
        self.textField?.text = priceString
        
        self.imageView?.image = currency?.image
        
        self.currencyLabel?.text = currency?.currencySymbol
        
        self.onTextChanged = _onTextChanged
        
        self.applyTheme()
        
        return self
    }
    
    func update(value: Double?) {
        
        self.textField?.text = String(format: "%.2f", value ?? 0.0)
    }
    
    private func applyTheme() {
        
        let theme = AppDelegate.shared?.theme ?? .standard
        
        switch theme {
        case .red:
        
            self.containerView?.borderColor = .borderRed
        
            self.dividerView?.backgroundColor = .borderRed
            
            self.currencyLabel?.textColor = .red
            
            self.textField?.textColor = .red
            
            self.textField?.tintColor = .red
            
            self.textField?.placeHolderColor = .borderRed
            
        default:
        
            self.containerView?.borderColor = .borderGray
        
            self.dividerView?.backgroundColor = .borderGray
            
            self.textField?.placeHolderColor = .borderGray
                
            self.currencyLabel?.textColor = .darkGray
            
            self.textField?.textColor = .darkGray
            
            self.textField?.tintColor = .darkGray
        }
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
