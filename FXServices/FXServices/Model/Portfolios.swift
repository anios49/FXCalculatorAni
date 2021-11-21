//
//  Portfolios.swift
//  FXServices
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

// MARK: - Portfolios
public struct Portfolios: Codable {
    public let fx: Fx?
    
    enum CodingKeys: String, CodingKey {
        case fx = "FX"
    }
}
