//
//  Brands.swift
//  FXServices
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

// MARK: - Brands
public struct Brands: Codable {
    public let wbc: Wbc?
    
    enum CodingKeys: String, CodingKey {
        case wbc = "WBC"
    }
}
