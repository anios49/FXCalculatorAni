//
//  ButtonComponent.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import UIKit

public protocol ButtonComponentDataSource {
    var title: UIControlValue<String> { get }
}

class ButtonComponent: UIButton {
    //MARK: - Constant
    static let cornerRadius:CGFloat = 10.0
    static let borderWidth:CGFloat = 1.0
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func show(data: ButtonComponentDataSource) {
        setTitle(data.title.stringValue, for: .normal)
        accessibilityValue = data.title.stringValue
        accessibilityIdentifier = data.title.accessibilityIdentifier
    }
    
    public func setStyle(titleFont: UIFont = Theme.appearance.font.basicFont.title,
                         primaryColor: UIColor = Theme.appearance.color.basicColor.primaryColor,
                         secondaryColor: UIColor = Theme.appearance.color.basicColor.secondaryColor
        ) {
        titleLabel?.font = titleFont
        setTitleColor(primaryColor, for: .normal)
        layer.cornerRadius = ButtonComponent.cornerRadius
        layer.borderWidth = ButtonComponent.borderWidth
        layer.borderColor = secondaryColor.cgColor
    }
    
}
