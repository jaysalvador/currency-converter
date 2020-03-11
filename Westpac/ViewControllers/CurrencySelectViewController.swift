//
//  CurrencySelectViewController.swift
//  Westpac
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Currency

typealias CurrencySelectedClosure = ((Currency) -> Void)

class CurrencySelectViewController: JCollectionViewController<CurrencySection, CurrencyItem> {
    
    // MARK: - View model
    
    private var viewModel: CurrencyViewModelProtocol?
    
    private var onCurrencySelectedClosure: CurrencySelectedClosure?
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    /// Convenience init that declares a default viewmodel
    convenience override init() {
        
        self.init(viewModel: CurrencyViewModel(), onCurrencySelectedClosure: nil)
    }
    
    /// Creates a new `CurrencyViewController` with a custom ViewModel that adheres to `CurrencyViewModelProtocol`
    /// - Parameter _viewModel: a ViewModel that applies `CurrencyViewModelProtocol`
    init(viewModel _viewModel: CurrencyViewModelProtocol?, onCurrencySelectedClosure: CurrencySelectedClosure? = nil) {
        
        super.init()
        
        self.viewModel = _viewModel
        
        self.onCurrencySelectedClosure = onCurrencySelectedClosure
    }
    
    /// generates the items based on the data given by the `ViewModel` that will be rendered on the `CollectionView`
    override var sectionsAndItems: Array<SectionAndItems> {
        
        var items = [CurrencyItem]()
        
        self.viewModel?.currencies?
            .sorted {
                
                ($0.country ?? "") < ($1.country ?? "")
            }
            .forEach { currency in
            
                items.append(.currency(currency))
            }
        
        return [(.section, items)]
    }
    
    // MARK: - Setup
    
    /// Register cells
    override func setupCollectionView() {
        
        super.setupCollectionView()
        
        self.collectionView?.register(cell: CurrencySelectCell.self)
    }
    
    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
    /// Renders all the items
    override func collectionView(_ collectionView: UICollectionView, cellForSection section: CurrencySection, item: CurrencyItem, indexPath: IndexPath) -> UICollectionViewCell? {
        
        if case .currency(let currency) = item {
            
            if let cell = self.collectionView?.dequeueReusable(cell: CurrencySelectCell.self, for: indexPath) {
                
                return cell.prepare(currency: currency, isSelected: currency == self.viewModel?.selectedCurrency)
            }
        }
        
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAtSection section: CurrencySection, item: CurrencyItem) {
        
        if case .currency(let currency) = item {

            self.onCurrencySelectedClosure?(currency)
            
            self.dismiss()
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForSection section: CurrencySection, item: CurrencyItem, indexPath: IndexPath) -> CGSize? {
        
        return CGSize(width: collectionView.frame.width, height: 64.0)
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonTouchUpInside(_ sender: UIButton) {
        
        self.dismiss()
    }
    
    func dismiss() {
        
        self.dismiss(animated: true, completion: nil)
    }
}
