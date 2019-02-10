//
//  PaymentMethodsBuilder.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol PaymentMethodsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var apiService: MPEApi { get }
    var paymentFlowBuilder: PaymentFlowDataBuilder { get }
}

final class PaymentMethodsComponent: Component<PaymentMethodsDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var apiService: MPEApi {
        return dependency.apiService
    }

    var paymentFlowBuilder: PaymentFlowDataBuilder {
        return dependency.paymentFlowBuilder
    }
}

// MARK: - Builder

protocol PaymentMethodsBuildable: Buildable {
    func build(withListener listener: PaymentMethodsListener) -> PaymentMethodsRouting
}

final class PaymentMethodsBuilder: Builder<PaymentMethodsDependency>, PaymentMethodsBuildable {

    override init(dependency: PaymentMethodsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PaymentMethodsListener) -> PaymentMethodsRouting {
        let component = PaymentMethodsComponent(dependency: dependency)
        let viewController = PaymentMethodsViewController()
        let interactor = PaymentMethodsInteractor(presenter: viewController, apiService: component.apiService, paymentFlowBuilder: component.paymentFlowBuilder)
        interactor.listener = listener
        return PaymentMethodsRouter(interactor: interactor, viewController: viewController)
    }
}
