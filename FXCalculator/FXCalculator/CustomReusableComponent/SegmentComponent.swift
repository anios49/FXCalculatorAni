//
//  SegmentComponent.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 14/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import UIKit

public protocol SegmentComponentDataSource {
    var firstSegment: UIControlValue<String> { get }
    var secondSegment: UIControlValue<String> { get }
}
class SegmentComponent: UISegmentedControl {
    //MARK: - Constant
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
    
    public func show(data: SegmentComponentDataSource) {
        removeAllSegments()
        insertSegment(withTitle: data.firstSegment.stringValue, at: 0, animated: false)
        accessibilityValue = data.firstSegment.stringValue
        accessibilityIdentifier = data.firstSegment.accessibilityIdentifier
        selectedSegmentIndex = 0

        insertSegment(withTitle: data.secondSegment.stringValue, at: 1, animated: false)
        accessibilityValue = data.secondSegment.stringValue
        accessibilityIdentifier = data.secondSegment.accessibilityIdentifier
    }
    
    public func setStyle(titleFont: UIFont = Theme.appearance.font.basicFont.title,
                         primaryColor: UIColor = Theme.appearance.color.basicColor.primaryColor,
                         secondaryColor: UIColor = Theme.appearance.color.basicColor.secondaryColor
        ) {
        tintColor = primaryColor
        layer.borderWidth = SegmentComponent.borderWidth
        layer.borderColor = secondaryColor.cgColor
    }
}
