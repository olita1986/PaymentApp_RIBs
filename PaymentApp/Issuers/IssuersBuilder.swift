//
//  IssuersBuilder.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol IssuersDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var apiService: MPEApi { get }
    var paymentFlowBuilder: PaymentFlowDataBuilder { get }
}

final class IssuersComponent: Component<IssuersDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var apiService: MPEApi {
        return dependency.apiService
    }

    var paymentFlowBuilder: PaymentFlowDataBuilder {
        return dependency.paymentFlowBuilder
    }
}

// MARK: - Builder

protocol IssuersBuildable: Buildable {
    func build(withListener listener: IssuersListener, bankResponse: BanksResponse) -> IssuersRouting
}

final class IssuersBuilder: Builder<IssuersDependency>, IssuersBuildable {

    override init(dependency: IssuersDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: IssuersListener,
               bankResponse: BanksResponse) -> IssuersRouting {
        let component = IssuersComponent(dependency: dependency)
        let viewController = IssuersViewController()
        let interactor = IssuersInteractor(presenter: viewController, apiService: component.apiService, bankResponse: bankResponse, paymentFlowBuilder: component.paymentFlowBuilder)
        interactor.listener = listener
        return IssuersRouter(interactor: interactor, viewController: viewController)
    }
}
