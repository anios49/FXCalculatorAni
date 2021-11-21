//
//  Extensions.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import UIKit


extension UIView {
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)),
                                                                         owner: self, options: nil)?.first as? T else {
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutIfNeeded()
        return contentView
    }
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
