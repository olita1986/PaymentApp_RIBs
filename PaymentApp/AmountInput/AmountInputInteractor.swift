//
//  AmountInputInteractor.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift

protocol AmountInputRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AmountInputPresentable: Presentable {
    var listener: AmountInputPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func presentEnabledContinueButton()
    func presentDisabledContinueButton()
}

protocol AmountInputListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didInputAmount(amount: String)
}

final class AmountInputInteractor: PresentableInteractor<AmountInputPresentable>, AmountInputInteractable, AmountInputPresentableListener {

    weak var router: AmountInputRouting?
    weak var listener: AmountInputListener?

    private let paymentFlowBuilder: PaymentFlowDataBuilder

    private var amount = ""

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: AmountInputPresentable,
                  paymentFlowBuilder: PaymentFlowDataBuilder) {
        self.paymentFlowBuilder = paymentFlowBuilder
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    func textFieldDidChange(text: String) {
        if let amount = Int(text), amount > 10 {
            _ = paymentFlowBuilder.withAmount(amount: text)
            self.amount = text
            presenter.presentEnabledContinueButton()
        } else {
            presenter.presentDisabledContinueButton()
        }
    }

    func inputAmount() {
        listener?.didInputAmount(amount: self.amount)
    }
}
