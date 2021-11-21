//
//  FXCalculatorViewModel.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation
import FXServices

public enum TransactionType: String {
    case telegraphicTransfer
    case cash
}

public enum TransactionMode: String {
    case buying
    case selling
}

protocol FXCalculatorViewModelDelegate: class {
    func reloadData(fxRates: FXRates)
    func updateCurrency(result: String, dataSource: CurrencyViewComponentDataSource)
    func updatePickerData(currencyList: [String])
}

final class FXCalculatorViewModel {
    
    // MARK: - Constants
    let fxRates: FXRates
    let transactionModeArray = [NSLocalizedString("localiseBuying", comment: ""),
                                NSLocalizedString("localiseSelling", comment: "")]
    
    let transactionTypeArray = [NSLocalizedString("localiseTelegraphicTransfer", comment: ""),
                                NSLocalizedString("localiseCash", comment: "")]
    
    // MARK: - Variables
    weak var delegate:FXCalculatorViewModelDelegate?
    public var selectedCurrency = ""
    public var selectedSegments = [TransactionMode.buying.rawValue,
                                             TransactionType.telegraphicTransfer.rawValue]
    var currencyList: [String] = []
    var currencyCountryList: [String] = []
    var resultCurrency = ""
    
    // MARK: - initializer
    public init(fxRates: FXRates) {
        self.fxRates = fxRates
    }
    
    func reloadData(){
        delegate?.reloadData(fxRates: fxRates)
    }
    
    /**
     FX Rates Calculation Logic
     - Parameter dataSource: CurrencyViewComponentDataSource
     */
    func conversion(dataSource: CurrencyViewComponentDataSource) {
        if dataSource.textFieldText.stringValue.isEmpty {
            resultCurrency = ""
        }
        else{
            let isAudTextField = (dataSource.buttonText.stringValue == Constants.Currency.aud) ? true : false
            guard let selectedMode = selectedSegments.first, let selectedType = selectedSegments.last else { return }
            resultCurrency = currencyConversion(txMode: TransactionMode(rawValue: selectedMode) ?? .buying,
                                                txType: TransactionType(rawValue: selectedType) ?? .telegraphicTransfer,
                                                currency: dataSource.textFieldText.stringValue,
                                                isAudTextField: isAudTextField)
        }
        delegate?.updateCurrency(result: resultCurrency, dataSource: dataSource)
    }
    
    /**
     Currency Conversion By Checking Transaction Mode
     - Parameter txMode: Transaction Mode (Buying or Selling)
     - Parameter txType: Transaction Type (Cash or Telegraphic Transfer)
     - Parameter currency: Currency Amount
     - Parameter isAudTextField: Boolean to check active text field
     */
    private func currencyConversion(txMode: TransactionMode,
                                    txType: TransactionType,
                                    currency: String = "", isAudTextField: Bool) -> String {
        guard let product = fxRates.data?.brands?.wbc?.portfolios?.fx?.products?[selectedCurrency],
            let rates = product.Rates?[product.ProductId ?? ""] else { return Constants.notAvailableResult}
        
        switch txMode {
        case .buying:
            return buyingFxRates(rates: rates,
                                 txType: txType,
                                 currency: currency,
                                 isAudTextField: isAudTextField)
        case .selling:
            return sellingFxRates(rates: rates,
                                  txType: txType,
                                  currency: currency,
                                  isAudTextField: isAudTextField)
        }
        
    }
    
    /**
     Buying FX Rates
     - Parameter rates: Current Rates of 1 currency unit
     - Parameter txType: Transaction Type (Cash or Telegraphic Transfer)
     - Parameter currency: Currency Amount
     - Parameter isAudTextField: Boolean to check active text field
     */
    private func buyingFxRates(rates: Rates, txType: TransactionType, currency: String, isAudTextField: Bool) -> String {
        guard let buyNotes = rates.buyNotes, let buyTT = rates.buyTT  else { return Constants.notAvailableResult }
        switch txType {
        case .cash:
            if buyNotes == Constants.notAvailable {
                return Constants.notAvailableResult
            }
            return finalConversionRates(conversionRates: buyNotes,
                                        currency: currency,
                                        isAudTextField: isAudTextField)
        case .telegraphicTransfer:
            if buyTT == Constants.notAvailable {
                return Constants.notAvailableResult
            }
            return finalConversionRates(conversionRates: buyTT,
                                        currency: currency,
                                        isAudTextField: isAudTextField)
        }
    }
    
    /**
     Selling FX Rates
     - Parameter rates: Current Rates of 1 currency unit
     - Parameter txType: Transaction Type (Cash or Telegraphic Transfer)
     - Parameter currency: Currency Amount
     - Parameter isAudTextField: Boolean to check active text field
     */
    private func sellingFxRates(rates: Rates, txType: TransactionType, currency: String, isAudTextField: Bool) -> String {
        guard let sellNotes = rates.sellNotes,
            let sellTT = rates.sellTT  else { return Constants.notAvailableResult }
        switch txType {
        case .cash:
            if sellNotes == Constants.notAvailable {
                return Constants.notAvailableResult
            }
            return finalConversionRates(conversionRates: sellNotes,
                                        currency: currency,
                                        isAudTextField: isAudTextField)
        case .telegraphicTransfer:
            if sellTT == Constants.notAvailable {
                return Constants.notAvailableResult
            }
            return finalConversionRates(conversionRates: sellTT,
                                        currency: currency,
                                        isAudTextField: isAudTextField)
        }
    }
    
    /**
    Final Conversion FX Rates
    - Parameter conversionRates: Current Rates of 1 currency unit
    - Parameter currency: Currency Amount
    - Parameter isAudTextField: Boolean to check active text field
    */
    private func finalConversionRates(conversionRates: String, currency:  String, isAudTextField: Bool) -> String {
        guard let conversionRates = Double(conversionRates) else { return Constants.notAvailableResult}
        if isAudTextField {
            if currency.isEmpty {return ""}
            guard let audCurrency = Double(currency) else { return Constants.notAvailableResult}
            return String((audCurrency * conversionRates).rounded(toPlaces: 2))
        }
        else {
            if currency.isEmpty {return ""}
            guard let otherCurrency = Double(currency) else { return Constants.notAvailableResult}
            return String((otherCurrency / conversionRates).rounded(toPlaces: 2))
        }
    }
    
    ///Picker Data
    func pickerData() {
        fxRates.data?.brands?.wbc?.portfolios?.fx?.products?.forEach({ product in
            guard let productID = product.value.ProductId,
                let countryName = product.value.Rates?[productID]?.country else { return }
            let displayName = "\(productID) (\(countryName))"
            currencyCountryList.append(displayName)
            currencyList.append(productID)
        })
        currencyCountryList = currencyCountryList.sorted{ $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        currencyList = currencyList.sorted()
        delegate?.updatePickerData(currencyList: currencyCountryList)
    }
}
