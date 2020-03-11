//
//  ViewController.swift
//  Westpac
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Currency

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let client = CurrencyClient()
        
        client?.getCurrencies { (response) in
            
            switch response {
            case .success(let result):
                
                print(result.currencies)
            case .failure(let error):
                
                print(error)
            }
        }
    }
}

