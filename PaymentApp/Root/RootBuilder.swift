//
//  RootBuilder.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.

    var apiService: MPEApi {
        return shared { MPEApi() }
    }

    var paymentFlowBuilder: PaymentFlowDataBuilder {
        return shared { PaymentFlowDataBuilder() }
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)

        let amountInputBuilder = AmountInputBuilder(dependency: component)
        let paymentMethodsBuilder = PaymentMethodsBuilder(dependency: component)
        let issuersBuilder = IssuersBuilder(dependency: component)
        let installmentsBuilder = InstallmentsBuilder(dependency: component)
        let resultBuilder = ResultBuilder(dependency: component)
        return RootRouter(interactor: interactor, viewController: viewController, amountInputBuilder: amountInputBuilder, paymentMethodsBuilder: paymentMethodsBuilder, issuersBuilder: issuersBuilder, installmentsBuilder: installmentsBuilder, resultBuilder: resultBuilder)
    }
}
