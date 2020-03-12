//
//  UITextField.swift
//  Westpac
//
//  Created by Jay Salvador on 12/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension UITextField {
    
    @IBInspectable
    var placeHolderColor: UIColor? {
        
        get {
            
            return self.attributedPlaceholder?.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
        }
        set {
            
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
