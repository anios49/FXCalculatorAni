//
//  BaseViewController.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 14/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    
    static var spinnerView = UIView()

    //MARK: Activity Indicator
    class func startSpinner(onView : UIView) {
        spinnerView = .init(frame: onView.bounds)
        spinnerView.backgroundColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        spinnerView.tintColor = Theme.appearance.color.basicColor.secondaryColor
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.color = Theme.appearance.color.basicColor.secondaryColor
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
    }
    
    class func stopSpinner() {
        DispatchQueue.main.async {
            spinnerView.removeFromSuperview()
        }
    }
}
