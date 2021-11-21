//
//  FXCustomLabel.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import UIKit

//Foreign Exchange protocol for values
public protocol LabelComponentDataSource {
    var title: UIControlValue<String> { get }
}

class LabelComponent: UILabel {
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func show(data: LabelComponentDataSource) {
        text = data.title.stringValue
        accessibilityValue = data.title.stringValue
        accessibilityIdentifier = data.title.accessibilityIdentifier
    }
    
    public func setStyle(titleFont: UIFont = Theme.appearance.font.basicFont.title,
                         primaryColor: UIColor = Theme.appearance.color.basicColor.primaryColor,
                         secondaryColor: UIColor = Theme.appearance.color.basicColor.secondaryColor
        ) {
        font = titleFont
        textColor = primaryColor
    }
}
