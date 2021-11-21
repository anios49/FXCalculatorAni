//
//  Wbc.swift
//  FXServices
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

// MARK: - Wbc
public struct Wbc: Codable {
    public let brand: String?
    public let portfolios: Portfolios?
    
    enum CodingKeys: String, CodingKey {
        case brand = "Brand"
        case portfolios = "Portfolios"
    }
}
