//
//  ResultBuilder.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol ResultDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var paymentFlowBuilder: PaymentFlowDataBuilder { get }
}

final class ResultComponent: Component<ResultDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var paymentFlowBuilder: PaymentFlowDataBuilder {
        return dependency.paymentFlowBuilder
    }
}

// MARK: - Builder

protocol ResultBuildable: Buildable {
    func build(withListener listener: ResultListener) -> ResultRouting
}

final class ResultBuilder: Builder<ResultDependency>, ResultBuildable {

    override init(dependency: ResultDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ResultListener) -> ResultRouting {
        let component = ResultComponent(dependency: dependency)
        let viewController = ResultViewController()
        let interactor = ResultInteractor(presenter: viewController, paymentFlowBuilder: component.paymentFlowBuilder)
        interactor.listener = listener
        return ResultRouter(interactor: interactor, viewController: viewController)
    }
}
