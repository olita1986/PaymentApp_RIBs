//
//  RootRouter.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, AmountInputListener, PaymentMethodsListener, IssuersListener, InstallmentsListener, ResultListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func showView(view: ViewControllable)
    func pushView(view: ViewControllable)
    func popToRoot()
    func popView()
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // Builders
    private let amountInputBuilder: AmountInputBuilder
    private let paymentMethodsBuilder: PaymentMethodsBuilder
    private let issuersBuilder: IssuersBuilder
    private let installmentsBuilder: InstallmentsBuilder
    private let resultBuilder: ResultBuilder

    private var currentChild: Routing?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         amountInputBuilder: AmountInputBuilder,
         paymentMethodsBuilder: PaymentMethodsBuilder,
         issuersBuilder: IssuersBuilder,
         installmentsBuilder: InstallmentsBuilder,
         resultBuilder: ResultBuilder) {
        self.amountInputBuilder = amountInputBuilder
        self.paymentMethodsBuilder = paymentMethodsBuilder
        self.issuersBuilder = issuersBuilder
        self.installmentsBuilder = installmentsBuilder
        self.resultBuilder = resultBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        attachMainView()
    }

    // Routes

    func routeToPrevious() {
        if let child = currentChild {
            detachChild(child)
            currentChild = nil
        }
        currentChild = children.last
    }

    func routeToStart() {
        for child in self.children {
            if !(child is AmountInputRouter) {
                detachChild(child)
            }
        }
        viewController.popToRoot()
    }

    func routeToResult() {
        let result = resultBuilder.build(withListener: interactor)
        attachChild(result)
        currentChild = result
        viewController.pushView(view: result.viewControllable)
    }

    func routeToInstallments(withInstallments installments: InstallmentsResponse) {
        let installments = installmentsBuilder.build(withListener: interactor, installmentsReponse: installments)
        attachChild(installments)
        currentChild = installments
        viewController.pushView(view: installments.viewControllable)
    }

    func routeToIssuers(withIssuers issuers: BanksResponse) {
        let issuers = issuersBuilder.build(withListener: interactor, bankResponse: issuers)
        attachChild(issuers)
        currentChild = issuers
        viewController.pushView(view: issuers.viewControllable)
    }

    func routeToPaymentMethods() {
        let paymentMethods = paymentMethodsBuilder.build(withListener: interactor)
        attachChild(paymentMethods)
        currentChild = paymentMethods
        viewController.pushView(view: paymentMethods.viewControllable)
    }

    private func attachMainView() {
        let amountInput = amountInputBuilder.build(withListener: interactor)
        attachChild(amountInput)
        currentChild = amountInput
        viewController.showView(view: amountInput.viewControllable)
    }
}
