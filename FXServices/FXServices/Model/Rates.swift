//
//  Rates.swift
//  FXServices
//
//  Created by Animesh Mishra on 13/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

// MARK: - Rates
public struct Rates:Codable {
    public let buyNotes: String?
    public let buyTC: String?
    public let buyTT: String?
    public let country: String?
    public let currencyCode: String?
    public let currencyName: String?
    public let effectiveDate_Fmt: String?
    public let LASTUPDATED: String?
    public let sellNotes: String?
    public let sellTT: String?
    public let SpotRate_Date_Fmt: String?
    public let updateDate_Fmt: String?
}
