//
//  ResultRouter.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

protocol ResultInteractable: Interactable {
    var router: ResultRouting? { get set }
    var listener: ResultListener? { get set }
}

protocol ResultViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ResultRouter: ViewableRouter<ResultInteractable, ResultViewControllable>, ResultRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ResultInteractable, viewController: ResultViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
