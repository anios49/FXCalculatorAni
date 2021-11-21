//
//  SegmentDataSource.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 14/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation
struct SegmentDataSource: SegmentComponentDataSource {
    var firstSegment: UIControlValue<String>
    var secondSegment: UIControlValue<String>
    
    init(firstSegment: String, secondSegment:String) {
        self.firstSegment = UIControlValue(stringValue: firstSegment)
        self.secondSegment = UIControlValue(stringValue: secondSegment)
    }
}
