//
//  AmountInputInteractorTests.swift
//  PaymentAppTests
//
//  Created by Nisum on 2/10/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

@testable import PaymentApp
import XCTest

final class AmountInputInteractorTests: XCTestCase {

    private var interactor: AmountInputInteractor!
    private var presenterMock: AmountInputPresentableMock!
    private var paymentFlowBuilder: PaymentFlowDataBuilder!
    private var listenerMock: AmountInputListenerMock!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        // TODO: instantiate objects and mocks
        paymentFlowBuilder = PaymentFlowDataBuilder()
        _ = paymentFlowBuilder.withAmount(amount: "no amount")
        presenterMock = AmountInputPresentableMock()
        listenerMock = AmountInputListenerMock()

        interactor = AmountInputInteractor(presenter: presenterMock, paymentFlowBuilder: paymentFlowBuilder)
        interactor.listener = listenerMock
    }

    // MARK: - Tests

    func testInputAmount() {
        interactor.inputAmount()

        XCTAssertTrue(listenerMock.didInputAmountCalled)
    }

    func testTextFieldDidChangeBelowTen() {
        interactor.textFieldDidChange(text: "9")
        let paymentData = paymentFlowBuilder.build()
        XCTAssertTrue(presenterMock.presentDisabledContinueButtonCalled)
        XCTAssertTrue(paymentData.amount == "no amount")
    }

    func testTextFieldDidChangeAboveTen() {
        interactor.textFieldDidChange(text: "11")
        let paymentData = paymentFlowBuilder.build()
        XCTAssertTrue(presenterMock.presentEnabledContinueButtonCalled)
        XCTAssertTrue(paymentData.amount == "11")
    }
}
