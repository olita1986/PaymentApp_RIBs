//
//  RootComponent+Issuers.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the Issuers scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyIssuers: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the Issuers scope.
}

extension RootComponent: IssuersDependency {

    // TODO: Implement properties to provide for Issuers scope.
}
