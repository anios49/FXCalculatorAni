//
//  LabelDataSource.swift
//  FXCalculator
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

struct LabelDataSource: LabelComponentDataSource {
    var title: UIControlValue<String>
    
    init(title: String) {
        self.title = UIControlValue(stringValue: title)
    }
}
