//
//  FXCalculatorDevTheme.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 14/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation
import UIKit

class FXCalculatorDevTheme: Appearance {
    var color: Colors = FXCalculatorDevColors()
    var font: Font = FXCalculatorDevFonts()
}

struct FXCalculatorDevColors: Colors {
    var basicColor: BasicColors = FXCalculatorDevBasicColors()
}

struct FXCalculatorDevFonts: Font {
    var basicFont: BasicFonts = FXCalculatorDevBasicFont()
}

struct FXCalculatorDevBasicColors: BasicColors {
    var primaryColor = UIColor.init(red: 0, green: 0, blue: 139/255, alpha: 1)
    var secondaryColor = UIColor.black
}
struct FXCalculatorDevBasicFont: BasicFonts {
    var footer = UIFont.preferredFont(forTextStyle: .footnote)
    var title = UIFont.preferredFont(forTextStyle: .title3)
    var body = UIFont.preferredFont(forTextStyle: .body)
}
