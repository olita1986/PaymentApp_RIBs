//
//  ResultViewModel.swift
//  PaymentApp
//
//  Created by Nisum on 2/10/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

struct ResultViewModel {
    let model: PaymentFlowData

    var installments: String {
        return String(model.selectedInstallment.installments)
    }
    var installmentValue: String {
        return String(model.selectedInstallment.installmentAmount)
    }
    var amount: String {
        return model.amount
    }
    var totalAmount: String {
        return String(model.selectedInstallment.totalAmount)
    }
    var paymentMethod: String {
        return model.selectedPaymentMethod.name
    }
    var issuer: String {
        return model.selectedIssuer.name
    }
}
