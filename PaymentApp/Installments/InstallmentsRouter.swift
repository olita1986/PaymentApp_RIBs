//
//  InstallmentsRouter.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol InstallmentsInteractable: Interactable {
    var router: InstallmentsRouting? { get set }
    var listener: InstallmentsListener? { get set }
}

protocol InstallmentsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class InstallmentsRouter: ViewableRouter<InstallmentsInteractable, InstallmentsViewControllable>, InstallmentsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: InstallmentsInteractable, viewController: InstallmentsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
