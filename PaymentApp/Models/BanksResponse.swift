//
//  BanksResponse.swift
//  MercadoPagoExample
//
//  Created by Orlando Arzola on 1/27/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

typealias BanksResponse = [BanksResponseElement]

struct BanksResponseElement: Codable {
    let id, name: String
    let secureThumbnail: String
    let thumbnail: String
    let processingMode: String
    let merchantAccountID: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case secureThumbnail = "secure_thumbnail"
        case thumbnail
        case processingMode = "processing_mode"
        case merchantAccountID = "merchant_account_id"
    }
}



