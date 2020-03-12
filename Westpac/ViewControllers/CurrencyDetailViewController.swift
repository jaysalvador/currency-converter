//
//  CurrencyDetailViewController.swift
//  Westpac
//
//  Created by Jay Salvador on 12/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Currency

enum CurrencyDetailSection: Equatable {
    
    case section
}

enum CurrencyDetailItem: Equatable {
    
    case currency(Currency)
    case details(Currency)
}

class CurrencyDetailViewController: JCollectionViewController<CurrencyDetailSection, CurrencyDetailItem> {
    
    @IBOutlet
    private var titleLabel: UILabel?
    
    @IBOutlet
    private var borderView: UIView?
    
    @IBOutlet
    private var backButton: UIButton?
    
    
    // MARK: - View model
    
    private var viewModel: CurrencyDetailViewModelProtocol?
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    /// Convenience init that declares a default viewmodel
    convenience init(value: Double?, source: Currency?, destination: Currency?) {
        
        self.init(
            viewModel: CurrencyDetailViewModel(
                value: value,
                source: source,
                destination: destination
            )
        )
    }
    
    init(viewModel _viewModel: CurrencyDetailViewModelProtocol?) {
        
        super.init()
        
        self.viewModel = _viewModel
    }
    
    /// generates the items based on the data given by the `ViewModel` that will be rendered on the `CollectionView`
    override var sectionsAndItems: Array<SectionAndItems> {
        
        var items = [CurrencyDetailItem]()
        
        if let source = self.viewModel?.source {
            
            items.append(.currency(source))
        }
        if let destination = self.viewModel?.destination {
            
            items.append(.currency(destination))
            items.append(.details(destination))
        }
        
        return [(.section, items)]
    }
    
    // MARK: - Setup
    
    /// Register cells
    override func setupCollectionView() {
        
        super.setupCollectionView()
        
        self.collectionView?.register(cell: CurrencyTextFieldCell.self)
        self.collectionView?.register(cell: CurrencyDetailsCell.self)
    }
    
    private func applyTheme() {
        
        let theme = AppDelegate.shared?.theme ?? .standard
        
        switch theme {
        case .red:
            
            self.borderView?.backgroundColor = .borderRed
            
            self.backButton?.tintColor = .red
            
            self.titleLabel?.textColor = .red
            
        default:
            
            self.borderView?.backgroundColor = .borderGray
                
            self.backButton?.tintColor = .darkGray
            
            self.titleLabel?.textColor = .darkGray
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.applyTheme()
        
        self.titleLabel?.text = "Exchange \(self.viewModel?.source?.currencyCode ?? "") to \(self.viewModel?.destination?.currencyCode ?? "")"
    }
    
    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
    /// Renders all the items
    override func collectionView(_ collectionView: UICollectionView, cellForSection section: CurrencyDetailSection, item: CurrencyDetailItem, indexPath: IndexPath) -> UICollectionViewCell? {
        
        switch item {
        case .currency(let currency):
            
            let isSource = currency == self.viewModel?.source
            
            let value = isSource == true ? self.viewModel?.value : self.viewModel?.value?.convertTo(currency: self.viewModel?.destination)
            
            let convertToCurrency = isSource == true ? self.viewModel?.destination : self.viewModel?.source
            
            if let cell = self.collectionView?.dequeueReusable(cell: CurrencyTextFieldCell.self, for: indexPath) {
                
                return cell.prepare(
                    value: value,
                    currency: currency,
                    onTextChanged: { [weak self] (value) in
                        
                        self?.reloadCell(value: value, currency: convertToCurrency)
                    }
                )
            }
        case .details(let currency):
        
            if let cell = self.collectionView?.dequeueReusable(cell: CurrencyDetailsCell.self, for: indexPath) {
                
                return cell.prepare(currency: currency)
            }
        }
        
        return nil
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForSection section: CurrencyDetailSection, item: CurrencyDetailItem, indexPath: IndexPath) -> CGSize? {
        
        switch item {
        case .currency:
            
            return CGSize(width: collectionView.frame.width, height: 72.0)
        case .details(let currency):

            return CurrencyDetailsCell.size(givenWidth: collectionView.frame.width, currency: currency)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func reloadCell(value: String?, currency: Currency?) {
        
        if let currency = currency,
            let cell = self.cell(forSection: .section, item: .currency(currency)) as? CurrencyTextFieldCell {
            
            let isSource = currency == self.viewModel?.source
            
            let price = Double(value ?? "0")
            
            let convertedPrice = isSource ? price?.buy(currency: self.viewModel?.destination) : price?.convertTo(currency: self.viewModel?.destination)
            
            cell.update(value: convertedPrice)
        }
    }
}
