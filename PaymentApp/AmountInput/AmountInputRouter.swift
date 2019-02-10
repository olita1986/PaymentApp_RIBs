//
//  AmountInputRouter.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol AmountInputInteractable: Interactable {
    var router: AmountInputRouting? { get set }
    var listener: AmountInputListener? { get set }
}

protocol AmountInputViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AmountInputRouter: ViewableRouter<AmountInputInteractable, AmountInputViewControllable>, AmountInputRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AmountInputInteractable, viewController: AmountInputViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
