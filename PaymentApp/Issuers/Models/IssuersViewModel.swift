//
//  IssuersViewModel.swift
//  PaymentApp
//
//  Created by Nisum on 2/10/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

struct IssuersViewModel {
    let model: BanksResponseElement

    var name: String {
        return model.name
    }
}


