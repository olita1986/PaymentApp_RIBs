//
//  PaymentMethodsResponse.swift
//  MercadoPagoExample
//
//  Created by Orlando Arzola on 1/27/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

typealias PaymentMethodsResponse = [PaymentMethodsElement]

struct PaymentMethodsElement: Codable {
    let id, name, thumbnail, secureThumbnail: String

    enum CodingKeys: String, CodingKey {
        case id, name, thumbnail
        case secureThumbnail = "secure_thumbnail"
    }
}
