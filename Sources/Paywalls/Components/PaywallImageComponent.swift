//
//  PaywallImageComponent.swift
//
//
//  Created by Josh Holtz on 6/12/24.
//
// swiftlint:disable missing_docs

import Foundation

#if PAYWALL_COMPONENTS

public extension PaywallComponent {

    struct ImageComponent: PaywallComponentBase {

        let type: ComponentType
        public let url: URL
        public let cornerRadius: Double
        public let gradientColors: [ColorHex]

        public init(
            url: URL,
            cornerRadius: Double = 0.0,
            gradientColors: [ColorHex] = []
        ) {
            self.type = .image
            self.url = url
            self.cornerRadius = cornerRadius
            self.gradientColors = gradientColors
        }

    }

}

#endif
