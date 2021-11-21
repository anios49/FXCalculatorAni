//
//  FXCalculatorTheme.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 14/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation
import UIKit

class FXCalculatorTheme: Appearance {
    var color: Colors = FXCalculatorColors()
    var font: Font = FXCalculatorFonts()
}

struct FXCalculatorColors: Colors {
    var basicColor: BasicColors = FXCalculatorBasicColors()
}

struct FXCalculatorFonts: Font {
    var basicFont: BasicFonts = FXCalculatorBasicFont()
}

struct FXCalculatorBasicColors: BasicColors {
    var primaryColor = UIColor.init(red: 139/255, green: 0, blue: 0, alpha: 1)
    var secondaryColor = UIColor.black
}

struct FXCalculatorBasicFont: BasicFonts {
    var footer = UIFont.preferredFont(forTextStyle: .footnote)
    var title = UIFont.preferredFont(forTextStyle: .title3)
    var body = UIFont.preferredFont(forTextStyle: .body)
}
