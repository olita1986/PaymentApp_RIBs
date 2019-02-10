//
//  MPEApi.swift
//  MercadoPagoExample
//
//  Created by Orlando Arzola on 1/28/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

class MPEApi: PaymentMethodsProtocol, BankIssuersProtocol, InstallmentsProtocol {
    let client: Client
    init(client: Client = AlamoFireClient()) {
        self.client = client
    }
    func getPaymentMethods(onSuccess: @escaping (_ paymentMethods: PaymentMethodsResponse?) -> Void) {
        let string = Constants.API.paymentMethodsURL
        let url = URL(string: string)!
        client.genericRequest(withType: PaymentMethodsResponse.self, url: url, onSuccess: onSuccess)
    }

    func getIssuers(withPaymentMethodId id: String, onSuccess: @escaping (BanksResponse?) -> Void) {
        let string = String(format: Constants.API.bankIssuersURL, id)
        let url = URL(string: string)!
        client.genericRequest(withType: BanksResponse.self, url: url, onSuccess: onSuccess)
    }

    func getInstallments(withPaymentMethodId id: String, amount: String, issuerId: String, onSuccess: @escaping (InstallmentsResponse?) -> Void) {
        let string = String(format: Constants.API.installmentsURL, amount, id, issuerId)
        let url = URL(string: string)!
        client.genericRequest(withType: InstallmentsResponse.self, url: url, onSuccess: onSuccess)
    }
}

protocol PaymentMethodsProtocol {
    func getPaymentMethods(onSuccess: @escaping (_ paymentMethods: PaymentMethodsResponse?) -> Void)
}

protocol BankIssuersProtocol {
    func getIssuers(withPaymentMethodId id: String, onSuccess: @escaping (_ paymentMethods: BanksResponse?) -> Void)
}

protocol InstallmentsProtocol {
    func getInstallments(withPaymentMethodId id: String, amount: String, issuerId: String, onSuccess: @escaping (_ paymentMethods: InstallmentsResponse?) -> Void)
}

protocol Client {
    func genericRequest<T: Decodable>(withType type: T.Type, url: URL, onSuccess: @escaping (_ decodedObject: T?) -> Void)
}
