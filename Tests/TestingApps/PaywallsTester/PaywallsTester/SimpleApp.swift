//
//  SimpleApp.swift
//  SimpleApp
//
//  Created by James Borthwick on 4/25/24.
//

import SwiftUI

@main
struct SimpleApp: App {

    struct IdentifiableString: Identifiable {

        let id: String
        
    }

    @State
    private var application = ApplicationData()

    @State
    private var paywallIDToShow: IdentifiableString?

    func getPaywallIdFrom(incomingURL: URL) -> IdentifiableString? {
        guard let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
            return nil
        }

        guard let params = components.queryItems else { return nil }

        guard let paywallID = params.first(where: { $0.name == "paywall" } )?.value else {
            return nil
        }

        return IdentifiableString(id: paywallID)
    }

    var body: some Scene {
        WindowGroup {
            AppContentView()
                .sheet(item: $paywallIDToShow) { paywallID in
                    LoginWall { response in
                        PaywallForID(apps: response.apps, id: paywallID.id)
                    }
                }
                .onOpenURL { URL in
                    // set to nil to trigger re-render if presenting same paywall with new data
                    paywallIDToShow = nil
                    paywallIDToShow = getPaywallIdFrom(incomingURL: URL)
                }
        }
        .environment(application)
    }

}
