//
//  Constants.swift
//  MercadoPagoExample
//
//  Created by Orlando Arzola on 1/27/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

struct Constants {
    struct API {
        static var paymentMethodsURL: String = "https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88"
        static var bankIssuersURL: String = "https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&payment_method_id=%@"
        static var installmentsURL: String = "https://api.mercadopago.com/v1/payment_methods/installments?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&amount=%@&payment_method_id=%@&issuer.id=%@"
    }
}
