//
//  PaymentMethodViewModel.swift
//  PaymentApp
//
//  Created by Nisum on 2/9/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

struct PaymentMethodViewModel {
    let model: PaymentMethodsElement
    var name: String {
        return model.name
    }
}
