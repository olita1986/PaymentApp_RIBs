//
//  InstallmentsInteractor.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift

protocol InstallmentsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol InstallmentsPresentable: Presentable {
    var listener: InstallmentsPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func showInstallments(_ installments: [InstallmentViewModel])
}

protocol InstallmentsListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didSelectInstallment()
    func didNavigateBack()
}

final class InstallmentsInteractor: PresentableInteractor<InstallmentsPresentable>, InstallmentsInteractable, InstallmentsPresentableListener {

    weak var router: InstallmentsRouting?
    weak var listener: InstallmentsListener?

    private let installmentsResponse: InstallmentsResponse
    private let paymentFlowBuilder: PaymentFlowDataBuilder

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: InstallmentsPresentable,
                  installmentsResponse: InstallmentsResponse,
                  paymentFlowBuilder: PaymentFlowDataBuilder) {
        self.installmentsResponse = installmentsResponse
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

    func getInstallments() {
        let installmentsViewModel = installmentsResponse[0].payerCosts.map{ InstallmentViewModel(model: $0)}
        presenter.showInstallments(installmentsViewModel)
    }

    func installmentSelected(withIndex index: Int) {
        let installment = installmentsResponse[0].payerCosts[index]
        _ = paymentFlowBuilder.withSelectedInstallment(installment: installment)
        listener?.didSelectInstallment()
    }

    func didNavigateBack() {
        listener?.didNavigateBack()
    }
}
