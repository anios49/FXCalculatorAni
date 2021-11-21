//
//  Theme.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import UIKit

/// Appearance protocol for entire app
public protocol Appearance {
    var color: Colors { get }
    var font: Font { get }
}

/// Colors protocol for entire app
public protocol Colors {
    var basicColor: BasicColors { get }
}

/// Font protocol for entire app
public protocol Font {
    var basicFont: BasicFonts { get }
}

/// Basic colours protocol for entire app
public protocol BasicColors {
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
}

/// Basic fonts protocol for entire app
public protocol BasicFonts {
    var title: UIFont { get }
    var body: UIFont { get }
    var footer: UIFont { get }
}

/* Theme is a common class for the whole application
 This will have Appearance and which will contains common colours and common Fonts
 for throughout the Application */
public class Theme {
    public static var appearance: Appearance!
}
