//
//  PaymentFlowData.swift
//  PaymentApp
//
//  Created by Nisum on 2/10/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

struct PaymentFlowData {
    var amount: String
    var selectedPaymentMethod: PaymentMethodsElement
    var selectedIssuer: BanksResponseElement
    var selectedInstallment: PayerCost
}

class PaymentFlowDataBuilder {
    var paymentFlow = PaymentFlowData(amount: "", selectedPaymentMethod: PaymentMethodsElement(id: "", name: "", thumbnail:"", secureThumbnail: ""), selectedIssuer: BanksResponseElement(id:"", name: "", secureThumbnail: "", thumbnail: "", processingMode: "", merchantAccountID: nil), selectedInstallment: PayerCost(installments: 0, installmentRate: 0.0, discountRate: 0, labels: [], installmentRateCollector: [], minAllowedAmount: 0, maxAllowedAmount: 0, recommendedMessage: "", installmentAmount: 0.0, totalAmount: 0))

    func withAmount(amount: String) -> PaymentFlowDataBuilder {
        paymentFlow.amount = amount
        return self
    }

    func withSelectedIssuer(issuer: BanksResponseElement) -> PaymentFlowDataBuilder {
        paymentFlow.selectedIssuer = issuer
        return self
    }

    func withSelectedPaymentMethod(method: PaymentMethodsElement) -> PaymentFlowDataBuilder {
        paymentFlow.selectedPaymentMethod = method
        return self
    }

    func withSelectedInstallment(installment: PayerCost) -> PaymentFlowDataBuilder {
        paymentFlow.selectedInstallment = installment
        return self
    }

    func build() -> PaymentFlowData {
        return paymentFlow
    }
}

