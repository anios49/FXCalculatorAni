//
//  Fx.swift
//  FXServices
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

// MARK: - Fx
public struct Fx: Codable {
    public let portfolioID: String?
    public let products: [String: Product]?
    
    enum CodingKeys: String, CodingKey {
        case portfolioID = "PortfolioId"
        case products = "Products"
    }
}
