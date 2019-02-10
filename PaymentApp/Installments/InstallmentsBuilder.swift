//
//  InstallmentsBuilder.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol InstallmentsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var paymentFlowBuilder: PaymentFlowDataBuilder { get }
}

final class InstallmentsComponent: Component<InstallmentsDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var paymentFlowBuilder: PaymentFlowDataBuilder {
        return dependency.paymentFlowBuilder
    }
}

// MARK: - Builder

protocol InstallmentsBuildable: Buildable {
    func build(withListener listener: InstallmentsListener,
               installmentsReponse: InstallmentsResponse) -> InstallmentsRouting
}

final class InstallmentsBuilder: Builder<InstallmentsDependency>, InstallmentsBuildable {

    override init(dependency: InstallmentsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: InstallmentsListener,
               installmentsReponse: InstallmentsResponse) -> InstallmentsRouting {
        let component = InstallmentsComponent(dependency: dependency)
        let viewController = InstallmentsViewController()
        let interactor = InstallmentsInteractor(presenter: viewController, installmentsResponse: installmentsReponse, paymentFlowBuilder: component.paymentFlowBuilder)
        interactor.listener = listener
        return InstallmentsRouter(interactor: interactor, viewController: viewController)
    }
}
