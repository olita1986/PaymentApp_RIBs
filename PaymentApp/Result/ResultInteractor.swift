//
//  ResultInteractor.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift

protocol ResultRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ResultPresentable: Presentable, LoadingPresentable {
    var listener: ResultPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func showResult(_ result: ResultViewModel)
}

protocol ResultListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didEndPaymentFlow()
}

final class ResultInteractor: PresentableInteractor<ResultPresentable>, ResultInteractable, ResultPresentableListener {

    weak var router: ResultRouting?
    weak var listener: ResultListener?

    private let paymentFlowBuilder: PaymentFlowDataBuilder

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ResultPresentable,
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

    func getResult() {
        let paymentData = paymentFlowBuilder.build()
        let resultViewModel = ResultViewModel(model: paymentData)
        presenter.showResult(resultViewModel)
    }

    func endPaymentFlow() {
        listener?.didEndPaymentFlow()
    }
}
