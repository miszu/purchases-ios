//
//  Copyright RevenueCat Inc. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  BaseSnapshotTest.swift
//
//  Created by Nacho Soto on 7/17/23.

import Nimble
import RevenueCat
@testable import RevenueCatUI
import SnapshotTesting
import SwiftUI
import XCTest

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@MainActor
class BaseSnapshotTest: TestCase {

    override class func setUp() {
        super.setUp()

        // isRecording = true
    }

    static func createPaywall(
        offering: Offering,
        mode: PaywallViewMode = .default,
        fonts: PaywallFontProvider = DefaultPaywallFontProvider(),
        introEligibility: TrialOrIntroEligibilityChecker = BaseSnapshotTest.eligibleChecker,
        purchaseHandler: PurchaseHandler = BaseSnapshotTest.purchaseHandler
    ) -> some View {
        return PaywallView(offering: offering,
                           customerInfo: TestData.customerInfo,
                           mode: mode,
                           fonts: fonts,
                           introEligibility: eligibleChecker,
                           purchaseHandler: purchaseHandler)
    }

}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension BaseSnapshotTest {

    static let eligibleChecker: TrialOrIntroEligibilityChecker = .producing(eligibility: .eligible)
    static let ineligibleChecker: TrialOrIntroEligibilityChecker = .producing(eligibility: .ineligible)
    static let purchaseHandler: PurchaseHandler = .mock()
    static let fonts: PaywallFontProvider = CustomPaywallFontProvider(fontName: "Papyrus")

    static let fullScreenSize: CGSize = .init(width: 460, height: 950)
    static let iPadSize: CGSize = .init(width: 744, height: 1130)
    static let footerSize: CGSize = .init(width: 460, height: 460)

}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {

    /// Adds the receiver to a view hierarchy to be able to test lifetime logic.
    func addToHierarchy() throws {
        if #available(iOS 17.0, *) {
            try XCTSkipIf(true, "This is currently not working on iOS 17")
        }

        UIView.setAnimationsEnabled(false)

        let controller = UIHostingController(
            rootView: self
                .frame(width: BaseSnapshotTest.fullScreenSize.width,
                       height: BaseSnapshotTest.fullScreenSize.height)
        )

        let window = UIWindow()
        window.isHidden = false
        window.rootViewController = controller
        window.frame.size = BaseSnapshotTest.fullScreenSize
        window.makeKeyAndVisible()

        window.addSubview(controller.view)
        controller.didMove(toParent: controller)

        window.setNeedsLayout()
        window.layoutIfNeeded()

        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()
    }

}