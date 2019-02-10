//
//  AmountInputMocks.swift
//  PaymentAppTests
//
//  Created by Nisum on 2/10/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation
@testable import PaymentApp
import RxSwift

class AmountInputInteractableMock: AmountInputInteractable {
    var router: AmountInputRouting?

    var listener: AmountInputListener?

    var activateCalled = false
    var deactivateCalled = false


    func activate() {
        activateCalled = true
    }

    func deactivate() {
        deactivateCalled = true
    }

    var isActive: Bool = false

    var isActiveStream: Observable<Bool> {
        return PublishSubject<Bool>()
    }
}

class AmountInputPresentableMock: AmountInputPresentable {
    var listener: AmountInputPresentableListener?

    var presentEnabledContinueButtonCalled = false
    var presentDisabledContinueButtonCalled = false

    func presentEnabledContinueButton() {
        presentEnabledContinueButtonCalled = true
    }

    func presentDisabledContinueButton() {
        presentDisabledContinueButtonCalled = true
    }
}

class AmountInputListenerMock: AmountInputListener {
    var didInputAmountCalled = false
    func didInputAmount(amount: String) {
        didInputAmountCalled = true
    }
}
