//
//  CurrencyViewComponent.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import UIKit

public protocol CurrencyViewComponentDataSource {
    var buttonText: UIControlValue<String> { get }
    var textFieldText: UIControlValue<String> { get set }
}

public protocol CurrencyViewComponentDelegate: class {
    func buttonAction(_ sender: Any, object:CurrencyViewComponent)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, dataSource: CurrencyViewComponentDataSource) -> Bool
    func presentAlert(title:String,message:String,buttonTitle:String)
}


public class CurrencyViewComponent: UIView {
    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var currencyPickerButton: UIButton!
    @IBOutlet private weak var currencyTextField:UITextField!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    var dataSource: CurrencyViewComponentDataSource?
    var delegate: CurrencyViewComponentDelegate?
    
    //MARK: - Constant
    static let cornerRadius:CGFloat = 10.0
    static let borderWidth:CGFloat = 1.0
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        fromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        fromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func show(data: CurrencyViewComponentDataSource) {
        dataSource = data
        currencyTextField.delegate = self
        currencyPickerButton.setTitle(data.buttonText.stringValue, for: .normal)
        currencyPickerButton.accessibilityIdentifier = data.buttonText.accessibilityIdentifier
        currencyPickerButton.accessibilityValue = data.buttonText.stringValue
        
        currencyTextField.text = data.textFieldText.stringValue
        currencyTextField.accessibilityIdentifier = data.textFieldText.accessibilityIdentifier
        currencyTextField.accessibilityValue = data.textFieldText.stringValue
    }
    
    public func setStyle(titleFont: UIFont = Theme.appearance.font.basicFont.title,
                         primaryColor: UIColor = Theme.appearance.color.basicColor.primaryColor,
                         secondaryColor: UIColor = Theme.appearance.color.basicColor.secondaryColor
        ) {
        currencyPickerButton.titleLabel?.font = titleFont
        currencyPickerButton.setTitleColor(primaryColor, for: .normal)
        currencyPickerButton.layer.cornerRadius = CurrencyViewComponent.cornerRadius
        currencyPickerButton.clipsToBounds = true
        currencyPickerButton.layer.borderWidth = CurrencyViewComponent.borderWidth
        currencyPickerButton.layer.borderColor = secondaryColor.cgColor
        
        currencyTextField.font = titleFont
        currencyTextField.textColor = primaryColor
        currencyTextField.layer.borderWidth = CurrencyViewComponent.borderWidth
        currencyTextField.layer.borderColor = secondaryColor.cgColor
        currencyTextField.tintColor = primaryColor
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        delegate?.buttonAction(sender,object: self)
    }
    
    func updateTextField(resultText:String) {
        dataSource?.textFieldText.stringValue = resultText
        currencyTextField.text = resultText
    }
}

extension CurrencyViewComponent: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.text == Constants.notAvailableResult {
            textField.text = ""
        }
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharSet = NSCharacterSet(charactersIn:Constants.allowedRegx).inverted
        let compSepByCharInSet = string.components(separatedBy: allowedCharSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        if string != numberFiltered {
            delegate?.presentAlert(title: NSLocalizedString("localiseInputError", comment: ""),
                                   message: NSLocalizedString("localiseInputErrorMsg", comment: ""),
                                   buttonTitle: NSLocalizedString("localiseOk", comment: ""))
            return false
        }
        if validationTextField(string: string,textField: textField) {
            if let text = textField.text, let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                guard let dataSource = dataSource else { return true}
                return delegate?.textField(textField, shouldChangeCharactersIn: range, replacementString: updatedText, dataSource: dataSource) ?? true
            }
            else {
                return false
            }
        }
        return false
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func validationTextField(string:String, textField:UITextField) -> Bool {
        guard var totalStringAmount = textField.text else {
            return false
        }
        if let dotIndex = totalStringAmount.firstIndex(of: ".") {
            // Do not allow to enter more than 2 digits after dot
            if 2 < totalStringAmount.distance(from: dotIndex, to: totalStringAmount.endIndex) {
                if string.isEmpty {return true}
                delegate?.presentAlert(title: NSLocalizedString("localiseInputError", comment: ""),
                                       message: NSLocalizedString("localiseTwoDecimalErrorMsg", comment: ""),
                                       buttonTitle: NSLocalizedString("localiseOk", comment: ""))
                return false
            }
            
            // Do not allow second "."
            if "." == string {
                delegate?.presentAlert(title: NSLocalizedString("localiseInputError", comment: ""),
                                       message: NSLocalizedString("localiseDecimalErrorMsg", comment: ""),
                                       buttonTitle: NSLocalizedString("localiseOk", comment: ""))
                return false
            }
        }
        totalStringAmount += string

        guard let finalAmount = Int(totalStringAmount) else {
            return true
        }
        
        if finalAmount >= 1000000000 {
            if string.isEmpty {return true}
            delegate?.presentAlert(title: NSLocalizedString("localiseInputError", comment: ""),
                                   message: NSLocalizedString("localiseDigitAllowed", comment: ""),
                                   buttonTitle: NSLocalizedString("localiseOk", comment: ""))
            return false
        }
        return true
        
    }
}
