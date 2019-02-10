//
//  PaymentMethodsRouter.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol PaymentMethodsInteractable: Interactable {
    var router: PaymentMethodsRouting? { get set }
    var listener: PaymentMethodsListener? { get set }
}

protocol PaymentMethodsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PaymentMethodsRouter: ViewableRouter<PaymentMethodsInteractable, PaymentMethodsViewControllable>, PaymentMethodsRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: PaymentMethodsInteractable, viewController: PaymentMethodsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
