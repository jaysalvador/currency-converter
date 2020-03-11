//
//  CurrencyViewController.swift
//  Westpac
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Currency

/// List of sections the collectionview will render
enum CurrencySection: Equatable {
    
    case section
}

/// List of items the collectionview will render
enum CurrencyItem: Equatable {
    
    case currency(Currency)
    
    static func == (lhs: CurrencyItem, rhs: CurrencyItem) -> Bool {
        
        switch (lhs, rhs) {
                
        case (.currency(let lhsCurrency), .currency(let rhsCurrency)):
            
            return lhsCurrency == rhsCurrency
        }
    }
}

class CurrencyViewController: JCollectionViewController<CurrencySection, CurrencyItem> {
    
    // MARK: - View model
    
    private var viewModel: CurrencyViewModelProtocol?

    @IBOutlet
    private var textView: UITextField?
    
    @IBOutlet
    private var currencyLabel: UILabel?
    
    @IBOutlet
    private var currencyImageView: UIImageView?
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    /// Convenience init that declares a default viewmodel
    convenience override init() {
        
        self.init(viewModel: CurrencyViewModel())
    }
    
    /// Creates a new `CurrencyViewController` with a custom ViewModel that adheres to `CurrencyViewModelProtocol`
    /// - Parameter _viewModel: a ViewModel that applies `CurrencyViewModelProtocol`
    init(viewModel _viewModel: CurrencyViewModelProtocol?) {
        
        super.init()
        
        self.viewModel = _viewModel
        
        self.setupViewModel()
    }
    
    /// generates the items based on the data given by the `ViewModel` that will be rendered on the `CollectionView`
    override var sectionsAndItems: Array<SectionAndItems> {
        
        var items = [CurrencyItem]()
        
        var currencies = self.viewModel?.currencies
        
        currencies?.removeAll { [weak self] (currency) in

            return currency == self?.viewModel?.selectedCurrency
        }
        
        if let selectedCurrency = self.viewModel?.selectedCurrency,
            !selectedCurrency.isAUD {
            
            currencies = [selectedCurrency.toAUD]
        }
        
        currencies?
            .sorted {
                
                ($0.currencyCode ?? "") < ($1.currencyCode ?? "")
            }
            .forEach { currency in
                
                items.append(.currency(currency))
            }
        
        return [(.section, items)]
    }
    
    // MARK: - Setup
    
    /// setup the ViewModel callbacks and their behaviours
    private func setupViewModel() {
        
        self.viewModel?.onUpdated = { [weak self] in
            
            DispatchQueue.main.async {

                self?.updateSectionsAndItems(forced: true)
            }
        }
    }
    
    /// Register cells
    override func setupCollectionView() {
        
        super.setupCollectionView()
        
        self.collectionView?.register(cell: CurrencyCell.self)
    }
    
    // MARK: - View life cycle

    /// Load the currencies using the `Currency` library from the ViewModel
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.updateCurrencyButton()
        
        self.viewModel?.getCurrencies()
    }
    
    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
    /// Renders all the items
    override func collectionView(_ collectionView: UICollectionView, cellForSection section: CurrencySection, item: CurrencyItem, indexPath: IndexPath) -> UICollectionViewCell? {
        
        if case .currency(let currency) = item {
            
            if let cell = self.collectionView?.dequeueReusable(cell: CurrencyCell.self, for: indexPath) {
                
                return cell.prepare(price: Double(self.textView?.text ?? "0") ?? 0, currency: currency)
            }
        }
        
        return nil
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForSection section: CurrencySection, item: CurrencyItem, indexPath: IndexPath) -> CGSize? {
        
        return CGSize(width: collectionView.frame.width, height: 72.0)
    }
    
    // MARK: - Actions
    
    @IBAction func currencyButtonTouchUpInside(_ sender: UIButton) {
        
        let vc = CurrencySelectViewController(viewModel: self.viewModel) { [weak self] (selectedCurrency) in
            
            self?.viewModel?.selectedCurrency = selectedCurrency
            
            self?.updateCurrencyButton()
            
            self?.updateSectionsAndItems(forced: true)
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func updateCurrencyButton() {
        
        self.currencyLabel?.text = nil
        
        self.currencyImageView?.image = nil
        
        if let selectedCurrency = self.viewModel?.selectedCurrency {

            self.currencyLabel?.text = selectedCurrency.currencyCode
            
            self.currencyImageView?.image = selectedCurrency.image
        }
    }
}

extension CurrencyViewController: UITextFieldDelegate {

    // MARK: - UITextFieldDelegate
    
    @IBAction
    private func textFieldEditingDidBegin(_ textField: UITextField) {
        
    }
    
    @IBAction
    private func textFieldEditingChanged(_ textField: UITextField) {

        DispatchQueue.main.async { [weak self] in
            
            self?.viewModel?.getCurrencies()
        }
    }
    
    @IBAction
    private func textFieldEditingDidEnd(_ textField: UITextField) {
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
