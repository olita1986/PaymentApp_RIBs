//
//  Stubs.swift
//  MercadoPagoExample
//
//  Created by Orlando Arzola on 1/28/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation
import OHHTTPStubs

class Stubs: NSObject {
    func enableStubs() {
        // MARK: API Stubs
        let paymentMethodsFile = "GET_payment_methods_200.json"
        stub(condition: pathMatches("/payment_methods?")) { _ in
            return fixture(filePath: OHPathForFile(paymentMethodsFile, type(of: self))!, status: 200, headers: ["Content-Type" as NSObject: "application/json" as AnyObject]).requestTime(OHHTTPStubsDownloadSpeedWifi, responseTime: 1.0)
        }

        let bankIssuersFile = "GET_bank_issuers_200.json"
        stub(condition: pathMatches("/payment_methods/card_issuers?")) { _ in
            return fixture(filePath: OHPathForFile(bankIssuersFile, type(of: self))!, status: 200, headers: ["Content-Type" as NSObject: "application/json" as AnyObject]).requestTime(OHHTTPStubsDownloadSpeedWifi, responseTime: 1.0)
        }

        let installmentsFile = "GET_installments_200.json"
        stub(condition: pathMatches("/payment_methods/installments?")) { _ in
            return fixture(filePath: OHPathForFile(installmentsFile, type(of: self))!, status: 200, headers: ["Content-Type" as NSObject: "application/json" as AnyObject]).requestTime(OHHTTPStubsDownloadSpeedWifi, responseTime: 1.0)
        }
    }
}

