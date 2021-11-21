//
//  Product.swift
//  FXServices
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

// MARK: - Product
public struct Product: Codable {
    public let ProductId: String?
    public let Rates: [String: Rates]?
}
