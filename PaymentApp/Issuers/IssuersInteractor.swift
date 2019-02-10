//
//  IssuersInteractor.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift

protocol IssuersRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol IssuersPresentable: Presentable, LoadingPresentable {
    var listener: IssuersPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func showIssuers(_ issuers: [IssuersViewModel])
}

protocol IssuersListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didSelectIssuer(withInstallments installments: InstallmentsResponse)
}

final class IssuersInteractor: PresentableInteractor<IssuersPresentable>, IssuersInteractable, IssuersPresentableListener {

    weak var router: IssuersRouting?
    weak var listener: IssuersListener?

    private let apiService: MPEApi
    private let bankResponse: BanksResponse
    private let paymentFlowBuilder: PaymentFlowDataBuilder

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: IssuersPresentable,
         apiService: MPEApi,
         bankResponse: BanksResponse,
         paymentFlowBuilder: PaymentFlowDataBuilder) {
        self.paymentFlowBuilder = paymentFlowBuilder
        self.apiService = apiService
        self.bankResponse = bankResponse
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

    func getIssuer() {
        let issuersViewModel = bankResponse.map{ IssuersViewModel(model: $0) }
        presenter.showIssuers(issuersViewModel)
    }

    func issuerSelected(withIndex index: Int) {
        presenter.showLoading()
        let issuer = bankResponse[index]
        let paymentFlow = paymentFlowBuilder.withSelectedIssuer(issuer: issuer).build()
        apiService.getInstallments(withPaymentMethodId: paymentFlow.selectedPaymentMethod.id, amount: paymentFlow.amount, issuerId: issuer.id) { [weak self](response) in
            self?.presenter.hideLoading()
            if let installments = response, installments.count > 0 {
                self?.listener?.didSelectIssuer(withInstallments: installments)
            } else {
                self?.presenter.showError()
            }
        }
    }
    
}
