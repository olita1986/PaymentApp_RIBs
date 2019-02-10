//
//  RootComponent+AmountInput.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the AmountInput scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyAmountInput: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the AmountInput scope.
}

extension RootComponent: AmountInputDependency {

    // TODO: Implement properties to provide for AmountInput scope.
}
