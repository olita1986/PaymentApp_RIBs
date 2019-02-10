//
//  RootComponent+Result.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the Result scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyResult: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the Result scope.
}

extension RootComponent: ResultDependency {

    // TODO: Implement properties to provide for Result scope.
}
