//
//  InstallmentViewModel.swift
//  PaymentApp
//
//  Created by Nisum on 2/10/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

struct InstallmentViewModel {
    let model: PayerCost

    var installments: String {
        return String(model.installments)
    }

    var installmentValue: String {
        return String(model.installmentAmount)
    }

    var totalAmount: String {
        return String(model.totalAmount)
    }

    var recommendation: String {
        return model.recommendedMessage
    }
}
