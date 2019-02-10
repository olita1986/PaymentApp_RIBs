//
//  LoadingPresentable.swift
//  PaymentApp
//
//  Created by Nisum on 2/9/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation
import JGProgressHUD

protocol LoadingPresentable {
    func showLoading()
    func showError()
    func hideLoading()
}

class CustomViewController: UIViewController, LoadingPresentable {

    private let hud =  JGProgressHUD(style: .dark)
    func showLoading() {
        hud.show(in: view)
    }

    func showError() {
        let alert = UIAlertController(title: "Opps!", message: "Somethinf went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func hideLoading() {
        hud.dismiss()
    }
}

