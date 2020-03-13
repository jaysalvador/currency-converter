//
//  UIColor.swift
//  Westpac
//
//  Created by Jay Salvador on 12/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// defined Red Border for theming
    class var borderRed: UIColor {
        
        return UIColor.red.withAlphaComponent(0.2)
    }
    
    /// defined Gray Border for theming
    class var borderGray: UIColor {
        
        return UIColor.lightGray.withAlphaComponent(0.2)
    }
}
