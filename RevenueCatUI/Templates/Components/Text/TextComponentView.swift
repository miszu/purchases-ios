//
//  Copyright RevenueCat Inc. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  TextComponentView.swift
//
//  Created by Josh Holtz on 6/11/24.

import Foundation
import RevenueCat
import SwiftUI

#if PAYWALL_COMPONENTS

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct TextComponentView: View {

    @Environment(\.componentViewState)
    private var componentViewState

    @Environment(\.componentConditionType)
    private var componentConditionType

    private let viewModel: TextComponentViewModel

    internal init(viewModel: TextComponentViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        viewModel.styles(
            state: self.componentViewState,
            condition: self.componentConditionType
        ) { style in
            Text(style.text)
                .font(style.textStyle)
                .fontWeight(style.fontWeight)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(style.horizontalAlignment)
                .foregroundStyle(style.color)
                .padding(style.padding)
                .background(style.backgroundColor)
                .padding(style.margin)
        }
    }

}

#if DEBUG

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct TextComponentView_Previews: PreviewProvider {
    static var previews: some View {
        // Default
        TextComponentView(
            // swiftlint:disable:next force_try
            viewModel: try! .init(
                localizedStrings: [
                    "id_1": .string("Hello, world")
                ],
                component: .init(
                    text: "id_1",
                    color: .init(light: "#000000")
                )
            )
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Default")

        // Customizations
        TextComponentView(
            // swiftlint:disable:next force_try
            viewModel: try! .init(
                localizedStrings: [
                    "id_1": .string("Hello, world")
                ],
                component: .init(
                    text: "id_1",
                    fontFamily: nil,
                    fontWeight: .heavy,
                    color: .init(light: "#ff0000"),
                    backgroundColor: .init(light: "#dedede"),
                    padding: .init(top: 10,
                                   bottom: 10,
                                   leading: 20,
                                   trailing: 20),
                    margin: .init(top: 20,
                                  bottom: 20,
                                  leading: 10,
                                  trailing: 10),
                    textStyle: .footnote,
                    horizontalAlignment: .leading
                )
            )
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Customizations")

        // State - Selected
        TextComponentView(
            // swiftlint:disable:next force_try
            viewModel: try! .init(
                localizedStrings: [
                    "id_1": .string("Hello, world")
                ],
                component: .init(
                    text: "id_1",
                    color: .init(light: "#000000"),
                    state: .init(
                        selected: .init(
                            fontWeight: .black,
                            color: .init(light: "#ff0000"),
                            backgroundColor: .init(light: "#0000ff"),
                            padding: .init(top: 10,
                                           bottom: 10,
                                           leading: 10,
                                           trailing: 10),
                            margin: .init(top: 10,
                                          bottom: 10,
                                          leading: 10,
                                          trailing: 10),
                            textStyle: .title
                        ),
                        introOffer: .init()
                    )
                )
            )
        )
        .environment(\.componentViewState, .selected)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("State - Selected")

        // Condition - Landscape
        TextComponentView(
            // swiftlint:disable:next force_try
            viewModel: try! .init(
                localizedStrings: [
                    "id_1": .string("THIS SHOULDN'T SHOW"),
                    "id_2": .string("Showing landscape condition")
                ],
                component: .init(
                    text: "id_1",
                    color: .init(light: "#000000"),
                    conditions: .init(
                        mobileLandscape: .init(
                            text: "id_2"
                        )
                    )
                )
            )
        )
        .environment(\.componentConditionType, .mobileLandscape)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Condition - Landscape")

        // Condition - Has tablet but not tablet
        TextComponentView(
            // swiftlint:disable:next force_try
            viewModel: try! .init(
                localizedStrings: [
                    "id_1": .string("Showing mobile condition"),
                    "id_2": .string("SHOULDN'T SHOW TABLET")
                ],
                component: .init(
                    text: "id_1",
                    color: .init(light: "#000000"),
                    conditions: .init(
                        tablet: .init(
                            text: "id_2"
                        )
                    )
                )
            )
        )
        .environment(\.componentConditionType, .mobileLandscape)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Condition - Has tablet but not tablet")
    }
}

#endif

#endif
