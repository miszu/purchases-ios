//
//  Copyright RevenueCat Inc. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  PaywallPackageComponent.swift
//
//  Created by Josh Holtz on 9/27/24.

import Foundation

// swiftlint:disable missing_docs

#if PAYWALL_COMPONENTS

public extension PaywallComponent {

    struct PackageComponent: PaywallComponentBase {

        let type: ComponentType
        public let packageID: String
        public let isDefaultSelected: Bool
        public let stack: PaywallComponent.StackComponent

        public init(packageID: String,
                    isDefaultSelected: Bool,
                    stack: PaywallComponent.StackComponent
        ) {
            self.type = .package
            self.packageID = packageID
            self.isDefaultSelected = isDefaultSelected
            self.stack = stack
        }
    }

}

#endif