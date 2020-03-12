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
    private var iHaveLabel: UILabel?
    
    @IBOutlet
    private var currencyImageView: UIImageView?
    
    @IBOutlet
    private var chevronImageView: UIImageView?
    
    @IBOutlet
    private var borderView: UIView?
    
    @IBOutlet
    private var currencyButtonView: UIView?
    
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
    
    private func applyTheme() {
        
        let theme = AppDelegate.shared?.theme ?? .standard
        
        switch theme {
        case .red:
            
            self.currencyButtonView?.borderColor = .borderRed
            
            self.borderView?.backgroundColor = .borderRed
            
            self.currencyLabel?.textColor = .red
            
            self.chevronImageView?.tintColor = .red
            
            self.iHaveLabel?.textColor = .red
            
            self.textView?.textColor = .red
            
            self.textView?.tintColor = .red
            
        default:
        
            self.currencyButtonView?.borderColor = .borderGray
            
            self.borderView?.backgroundColor = .borderGray
        
            self.currencyLabel?.textColor = .darkGray
        
            self.chevronImageView?.tintColor = .darkGray
            
            self.iHaveLabel?.textColor = .darkGray
            
            self.textView?.textColor = .darkGray
            
            self.textView?.tintColor = .darkGray
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
        
        self.applyTheme()
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAtSection section: CurrencySection, item: CurrencyItem) {

        if case .currency(let currency) = item,
            let source = self.viewModel?.selectedCurrency {
            
            let source = source.isAUD ? currency.toAUD : source
            
            let destination = currency.isAUD ? source.toAUD : currency
            
            let value = Double(self.textView?.text ?? "0")
            
            let vc = CurrencyDetailViewController(
                value: value,
                source: source,
                destination: destination
            )
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
        
        self.textView?.contentVerticalAlignment = .center
        
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
    private func textFieldEditingChanged(_ textField: UITextField) {

        DispatchQueue.main.async { [weak self] in
            
            self?.viewModel?.getCurrencies()
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            
            return true
        }
        
        return Double(text + string) != nil
    }
}
