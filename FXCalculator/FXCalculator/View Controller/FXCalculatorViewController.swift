//
//  FXCalculatorViewController.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 10/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import UIKit
import FXServices

final class FXCalculatorViewController: UIViewController {
    
    // MARK: - Private Outlets
    @IBOutlet weak var segmentLabelComponet: LabelComponent!
    @IBOutlet weak var transactionModeSegmentControl: SegmentComponent!
    @IBOutlet weak var transactionTypeSegmentControl: SegmentComponent!
    @IBOutlet weak var transactionLabelComponent: LabelComponent!
    @IBOutlet weak var currencySelectionLabel: LabelComponent!
    @IBOutlet weak var audCurrencyComponent: CurrencyViewComponent!
    @IBOutlet weak var otherCurrencyComponent: CurrencyViewComponent!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var lastUpdatedTImeLabel: LabelComponent!
    
    // MARK: - Variables
    private var fxCalculatorViewModel: FXCalculatorViewModel?
    var currencyListData: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        }
    }
    
    //MARK: - Constant
    static let leadingMarginConstant:CGFloat = 16.0
    static let keyboardShiftConstant:CGFloat = 100.0
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationTitle()
        hideKeyboard()
        getFxRates()
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            addKeyboardObserver()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /**
     Get FX Rates Service Call.
     */
    func getFxRates() {
        
        ActivityIndicatorView.startSpinner(onView: view)
        Networking.fetchFXRates(shouldFail: false) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fxRates):
                self.fxCalculatorViewModel = FXCalculatorViewModel(fxRates: fxRates)
                self.fxCalculatorViewModel?.delegate = self
                self.fxCalculatorViewModel?.reloadData()
                self.fxCalculatorViewModel?.pickerData()
            case .failure(let error):
                DispatchQueue.main.async() {
                    let alert = AlertView.init(title: NSLocalizedString("localiseError", comment: ""),
                                               message: error.localizedDescription,
                                               buttonTitle: NSLocalizedString("localiseOk", comment: ""))
                    alert.showAlert(onController: self)
                }
            }
            ActivityIndicatorView.stopSpinner()
        }
    }
    
    // MARK: - SetUp View
    /**
     SetUp View
     - Parameter fxRates: FX Rates Model
     */
    private func setupView(fxRates: FXRates) {
        var labelDataSource = LabelDataSource(title: NSLocalizedString("localiseTxMode", comment: ""))
        segmentLabelComponet.show(data: labelDataSource)
        segmentLabelComponet.setStyle()
        
        var segmentControlDataSource = SegmentDataSource(firstSegment: fxCalculatorViewModel?.transactionModeArray.first ?? "",
                                                         secondSegment: fxCalculatorViewModel?.transactionModeArray.last ?? "")
        transactionModeSegmentControl.show(data: segmentControlDataSource)
        transactionModeSegmentControl.setStyle()
        
        labelDataSource = LabelDataSource(title: NSLocalizedString("localiseTxType", comment: ""))
        transactionLabelComponent.show(data: labelDataSource)
        transactionLabelComponent.setStyle()
        
        segmentControlDataSource = SegmentDataSource(firstSegment: fxCalculatorViewModel?.transactionTypeArray.first ?? "",
                                                     secondSegment: fxCalculatorViewModel?.transactionTypeArray.last ?? "")
        transactionTypeSegmentControl.show(data: segmentControlDataSource)
        transactionTypeSegmentControl.setStyle()
        
        labelDataSource = LabelDataSource(title: NSLocalizedString("localiseFxOptions", comment: ""))
        currencySelectionLabel.show(data: labelDataSource)
        currencySelectionLabel.setStyle()
        
        let audCurrencyDataSource = CurrencyComponentDataSource(buttonTitle: Constants.Currency.aud, textfieldText: "")
        audCurrencyComponent.show(data: audCurrencyDataSource)
        audCurrencyComponent.delegate = self
        audCurrencyComponent.tag = 0
        audCurrencyComponent.setStyle()
        audCurrencyComponent.containerWidthConstraint.constant = UIScreen.main.bounds.size.width/2.0 - FXCalculatorViewController.leadingMarginConstant
        
        let otherCurrencyDataSource = CurrencyComponentDataSource(buttonTitle: fxCalculatorViewModel?.currencyList.first ?? Constants.Currency.aed,
                                                                  textfieldText: "")
        otherCurrencyComponent.show(data: otherCurrencyDataSource)
        otherCurrencyComponent.delegate = self
        otherCurrencyComponent.tag = 1
        otherCurrencyComponent.setStyle()
        fxCalculatorViewModel?.selectedCurrency = fxCalculatorViewModel?.currencyList.first ?? Constants.Currency.aed
        otherCurrencyComponent.containerWidthConstraint.constant = UIScreen.main.bounds.size.width/2.0 - FXCalculatorViewController.leadingMarginConstant
        
        guard let product = fxRates.data?.brands?.wbc?.portfolios?.fx?.products?[Constants.Currency.usd],
            let rates = product.Rates?[product.ProductId ?? ""] else {
                return
        }
        
        labelDataSource = LabelDataSource(title:" \(NSLocalizedString("localiseLastUpdatedOn", comment: "")) \(String(rates.LASTUPDATED ?? ""))")
        lastUpdatedTImeLabel.show(data: labelDataSource)
        lastUpdatedTImeLabel.setStyle()
    }
    
    //MARK: - Segment Control & Tool Bar Actions
    @IBAction func txModeSegmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fxCalculatorViewModel?.selectedSegments[0] = TransactionMode.buying.rawValue
        }
        else {
            fxCalculatorViewModel?.selectedSegments[0] = TransactionMode.selling.rawValue
        }
        guard let dataSource = audCurrencyComponent.dataSource else { return }
        fxCalculatorViewModel?.conversion(dataSource: dataSource)
    }
    
    @IBAction func txTypeSegmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fxCalculatorViewModel?.selectedSegments[1] = TransactionType.telegraphicTransfer.rawValue
        }
        else {
            fxCalculatorViewModel?.selectedSegments[1] = TransactionType.cash.rawValue
        }
        guard let dataSource = audCurrencyComponent.dataSource else { return }
        fxCalculatorViewModel?.conversion(dataSource: dataSource)
    }
    
    ///Picker Tool Bar Done Button
    @IBAction func doneButtonTapped(_ sender: Any) {
        pickerView.isHidden = true
        toolBar.isHidden = true
    }
    
    /// Setting up navigation bar
    func setUpNavigationTitle() {
        title = NSLocalizedString("localiseFXCalculator", comment: "")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.appearance.color.basicColor.primaryColor]
        toolBar.tintColor = Theme.appearance.color.basicColor.primaryColor
    }
    
    //MARK: Keyboard Notifications & Methoeds
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height - FXCalculatorViewController.keyboardShiftConstant
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}

//MARK: Picker View Delegate Extension
extension FXCalculatorViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyListData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyListData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        otherCurrencyComponent.show(data:CurrencyComponentDataSource(buttonTitle: fxCalculatorViewModel?.currencyList[row] ?? "",
                                                                     textfieldText: ""))
        fxCalculatorViewModel?.selectedCurrency = fxCalculatorViewModel?.currencyList[row] ?? ""
        guard let dataSource = audCurrencyComponent.dataSource else { return }
        fxCalculatorViewModel?.conversion(dataSource: dataSource)
    }
}

//MARK: CurrencyViewComponent Delegate Extension
extension FXCalculatorViewController: CurrencyViewComponentDelegate {
    
    func presentAlert(title: String, message: String, buttonTitle: String) {
        let alert = AlertView.init(title: title, message: message, buttonTitle: buttonTitle)
        alert.showAlert(onController: self)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String,
                   dataSource: CurrencyViewComponentDataSource) -> Bool {
        if dataSource.buttonText.stringValue == Constants.Currency.aud {
            audCurrencyComponent.dataSource = CurrencyComponentDataSource(buttonTitle: Constants.Currency.aud,
                                                                          textfieldText:string)
            guard let dataSource = audCurrencyComponent.dataSource else { return true }
            fxCalculatorViewModel?.conversion(dataSource: dataSource)
        }
        else {
            otherCurrencyComponent.dataSource = CurrencyComponentDataSource(buttonTitle: dataSource.buttonText.stringValue,
                                                                            textfieldText:string)
            guard let dataSource = otherCurrencyComponent.dataSource else { return true }
            fxCalculatorViewModel?.conversion(dataSource: dataSource)
        }
        return true
    }
    
    func buttonAction(_ sender: Any, object: CurrencyViewComponent) {
        if object.tag == 0 {
            pickerView.isHidden = true
            toolBar.isHidden = true
        }
        else {
            pickerView.isHidden = false
            toolBar.isHidden = false
        }
    }
}

//MARK: FXCalculatorViewModelDelegate Extension
extension FXCalculatorViewController: FXCalculatorViewModelDelegate {
    func updateCurrency(result: String, dataSource: CurrencyViewComponentDataSource) {
        if dataSource.buttonText.stringValue == Constants.Currency.aud {
            otherCurrencyComponent.updateTextField(resultText: result)
        }
        else {
            audCurrencyComponent.updateTextField(resultText: result)
        }
    }
    
    func reloadData(fxRates: FXRates) {
        DispatchQueue.main.async {
            self.setupView(fxRates: fxRates)
            self.transactionModeSegmentControl.isHidden = false
            self.transactionTypeSegmentControl.isHidden = false
            self.audCurrencyComponent.isHidden = false
            self.otherCurrencyComponent.isHidden = false
        }
    }
    
    func updatePickerData(currencyList: [String]) {
        currencyListData = currencyList
    }
}
