//
//  AmountInputBuilder.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol AmountInputDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var paymentFlowBuilder: PaymentFlowDataBuilder { get }
}

final class AmountInputComponent: Component<AmountInputDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var paymentFlowBuilder: PaymentFlowDataBuilder {
        return dependency.paymentFlowBuilder
    }
}

// MARK: - Builder

protocol AmountInputBuildable: Buildable {
    func build(withListener listener: AmountInputListener) -> AmountInputRouting
}

final class AmountInputBuilder: Builder<AmountInputDependency>, AmountInputBuildable {

    override init(dependency: AmountInputDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AmountInputListener) -> AmountInputRouting {
        let component = AmountInputComponent(dependency: dependency)
        let viewController =  AmountInputViewController()
        let interactor = AmountInputInteractor(presenter: viewController, paymentFlowBuilder: component.paymentFlowBuilder)
        interactor.listener = listener
        return AmountInputRouter(interactor: interactor, viewController: viewController)
    }
}
