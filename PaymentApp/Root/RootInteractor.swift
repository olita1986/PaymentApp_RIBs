//
//  RootInteractor.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToPaymentMethods()
    func routeToIssuers(withIssuers issuers: BanksResponse)
    func routeToInstallments(withInstallments installments: InstallmentsResponse)
    func routeToResult()
    func routeToStart()
    func routeToPrevious()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
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

    func didInputAmount(amount: String) {
        // print("this is the amount: \(amount)")
        router?.routeToPaymentMethods()
    }

    func didSelectPaymentMethod(withIssuers issuers: BanksResponse) {
        router?.routeToIssuers(withIssuers: issuers)
    }

    func didSelectIssuer(withInstallments installments: InstallmentsResponse) {
        router?.routeToInstallments(withInstallments: installments)
    }

    func didSelectInstallment() {
        router?.routeToResult()
    }

    func didEndPaymentFlow() {
        router?.routeToStart()
    }

    func didNavigateBack() {
        router?.routeToPrevious()
    }
}
