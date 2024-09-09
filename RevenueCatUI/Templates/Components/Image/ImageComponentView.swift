//
//  Copyright RevenueCat Inc. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  ImageComponentView.swift
//
//  Created by Josh Holtz on 6/11/24.

import Foundation
import RevenueCat
import SwiftUI

#if PAYWALL_COMPONENTS

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct ImageComponentView: View {

    let viewModel: ImageComponentViewModel

    var body: some View {
        RemoteImage(url: viewModel.url) { (image, size) in
            Group {
                switch viewModel.contentMode {
                case .fit:
                    renderImage(image, size)
                case .fill:
                    // Need this to be in a clear color overlay so the image
                    // doesn't push/adjust any parent sizes
                    Color.clear.overlay {
                        renderImage(image, size)
                    }
                }
            }
            // Works as a max height for both fit and fill
            // using the CGSize of an image
            .applyIfLet(viewModel.maxHeight, apply: { view, value in
                Group {
                    if let height = viewModel.maxHeight {
                        view.frame(height: height)
                    } else {
                        view
                    }
                }
            })
        }
        .clipped()
    }

    private func renderImage(_ image: Image, _ size: CGSize) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: viewModel.contentMode)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: viewModel.gradientColors),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .roundedCorner(viewModel.cornerRadiuses.topLeading, corners: .topLeft)
            .roundedCorner(viewModel.cornerRadiuses.topTrailing, corners: .topRight)
            .roundedCorner(viewModel.cornerRadiuses.bottomLeading, corners: .bottomLeft)
            .roundedCorner(viewModel.cornerRadiuses.bottomTrailing, corners: .bottomRight)
    }

}

#endif
