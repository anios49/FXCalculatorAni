//
//  FXRates.swift
//  FXServices
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

// MARK: - FXRates
public struct FXRates: Codable {
    public let apiVersion: String?
    public let status: Int?
    public let data: DataClass?
}
