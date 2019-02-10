//
//  PaymentMethodsInteractor.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift

protocol PaymentMethodsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol PaymentMethodsPresentable: Presentable, LoadingPresentable {
    var listener: PaymentMethodsPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func showPaymentMethods(_ methods: [PaymentMethodViewModel])
}

protocol PaymentMethodsListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didSelectPaymentMethod(withIssuers issuers: BanksResponse)
}

final class PaymentMethodsInteractor: PresentableInteractor<PaymentMethodsPresentable>, PaymentMethodsInteractable, PaymentMethodsPresentableListener {

    weak var router: PaymentMethodsRouting?
    weak var listener: PaymentMethodsListener?

    private let apiService: MPEApi

    private var paymentMethods = PaymentMethodsResponse()

    private let paymentFlowBuilder: PaymentFlowDataBuilder

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: PaymentMethodsPresentable,
                  apiService: MPEApi,
                  paymentFlowBuilder: PaymentFlowDataBuilder) {
        self.apiService = apiService
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

    func paymentMethodSelected(withIndex index: Int) {
        presenter.showLoading()
        let selectedPaymentMethod = paymentMethods[index]
        _ = paymentFlowBuilder.withSelectedPaymentMethod(method: selectedPaymentMethod)
        apiService.getIssuers(withPaymentMethodId: selectedPaymentMethod.id) { [weak self](response) in
            self?.presenter.hideLoading()
            if let issuers = response, issuers.count > 0 {
                self?.listener?.didSelectPaymentMethod(withIssuers: issuers)
            } else {
                self?.presenter.showError()
            }
        }
    }

    func getPaymentMethods() {
        presenter.showLoading()
        apiService.getPaymentMethods { [weak self] (response) in
            self?.presenter.hideLoading()
            if let methods = response, methods.count > 0 {
                self?.paymentMethods = methods
                let methodsViewModel = methods.map{PaymentMethodViewModel(model: $0)}
                self?.presenter.showPaymentMethods(methodsViewModel)
            } else {
                self?.presenter.showError()
            }
        }
    }
}
