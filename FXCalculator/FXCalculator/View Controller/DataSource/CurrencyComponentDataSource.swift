//
//  CurrencyComponentDataSource.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

struct CurrencyComponentDataSource: CurrencyViewComponentDataSource {
    var buttonText: UIControlValue<String>
    var textFieldText: UIControlValue<String>
    
    init(buttonTitle: String,textfieldText: String) {
        self.buttonText = UIControlValue(stringValue: buttonTitle )
        self.textFieldText = UIControlValue(stringValue: textfieldText)
    }
}
