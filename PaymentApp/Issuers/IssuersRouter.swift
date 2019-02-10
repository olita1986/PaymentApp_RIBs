//
//  IssuersRouter.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol IssuersInteractable: Interactable {
    var router: IssuersRouting? { get set }
    var listener: IssuersListener? { get set }
}

protocol IssuersViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class IssuersRouter: ViewableRouter<IssuersInteractable, IssuersViewControllable>, IssuersRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: IssuersInteractable, viewController: IssuersViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
