//
//  DataClass.swift
//  FXServices
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

// MARK: - DataClass
public struct DataClass: Codable {
    public let brands: Brands?
    
    enum CodingKeys: String, CodingKey {
        case brands = "Brands"
    }
}
