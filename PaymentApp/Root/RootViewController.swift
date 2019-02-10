//
//  RootViewController.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UINavigationController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?

    func showView(view: ViewControllable) {
        setViewControllers([view.uiviewController], animated: false)
    }

    func pushView(view: ViewControllable) {
        pushViewController(view.uiviewController, animated: true)
    }

    func popToRoot() {
        popToRootViewController(animated: true)
    }

    func popView() {
        popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.backBarButtonItem?.action = #selector(printSomething)
    }
}
