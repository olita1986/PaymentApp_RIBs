//
//  InstallmentsResponse.swift
//  MercadoPagoExample
//
//  Created by Orlando Arzola on 1/28/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

typealias InstallmentsResponse = [InstallmentsResponseElement]

struct InstallmentsResponseElement: Codable {
    let paymentMethodID, paymentTypeID: String
    let issuer: Issuer
    let processingMode: String
    let merchantAccountID: String?
    let payerCosts: [PayerCost]

    enum CodingKeys: String, CodingKey {
        case paymentMethodID = "payment_method_id"
        case paymentTypeID = "payment_type_id"
        case issuer
        case processingMode = "processing_mode"
        case merchantAccountID = "merchant_account_id"
        case payerCosts = "payer_costs"
    }
}

struct Issuer: Codable {
    let id, name: String
    let secureThumbnail: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case secureThumbnail = "secure_thumbnail"
        case thumbnail
    }
}

struct PayerCost: Codable {
    let installments: Int
    let installmentRate: Double
    let discountRate: Int
    let labels, installmentRateCollector: [String]
    let minAllowedAmount, maxAllowedAmount: Int
    let recommendedMessage: String
    let installmentAmount, totalAmount: Double

    enum CodingKeys: String, CodingKey {
        case installments
        case installmentRate = "installment_rate"
        case discountRate = "discount_rate"
        case labels
        case installmentRateCollector = "installment_rate_collector"
        case minAllowedAmount = "min_allowed_amount"
        case maxAllowedAmount = "max_allowed_amount"
        case recommendedMessage = "recommended_message"
        case installmentAmount = "installment_amount"
        case totalAmount = "total_amount"
    }
}
