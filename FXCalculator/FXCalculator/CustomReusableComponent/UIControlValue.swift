//
//  UIControlValue.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 11/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//
import UIKit

public struct UIControlValue<T> {
    public var stringValue: T
    public var accessibilityIdentifier: String?
    public var accessibilityValue: String?

    public init(stringValue: T,
                accessibilityIdentifier: String? = nil,
                accessibilityValue: String? = nil) {
        self.stringValue = stringValue
        self.accessibilityIdentifier = accessibilityIdentifier
        self.accessibilityValue = accessibilityValue
    }
}
