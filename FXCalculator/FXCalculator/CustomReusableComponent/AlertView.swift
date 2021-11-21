//
//  AlertView.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 15/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import UIKit

final public class AlertView {
    let title: String?
    let message: String?
    let buttonTitle: String?
    
    public init (title: String? = nil,
                 message: String? = nil,
                 buttonTitle:String? = nil) {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    public func showAlert(onController: UIViewController,
                          action: ((UIAlertAction, Int) -> Void)? = nil,
                          cancel: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Theme.appearance.color.basicColor.primaryColor
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        
        onController.present(alert, animated: true)
    }
}
