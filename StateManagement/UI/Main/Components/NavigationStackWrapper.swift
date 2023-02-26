//
//  NavigationStackWrapper.swift
//  StateManagement
//
//  Created by Fišer Jakub on 21.02.2023.
//

import SwiftUI

struct NavigationStackWrapper: View {
    @StateObject var navigationModel: NavigationModel

    let root: Route

    init(root: Route) {
        self.root = root
        _navigationModel = StateObject(wrappedValue: .init())
    }

    var body: some View {
        NavigationStack(path: $navigationModel.path) {
            root.view
                .eraseToAnyView()
                .navigationDestination(for: Route.self, destination: { route in
                    route.view.eraseToAnyView()
                        .environmentObject(navigationModel)
                })
                .environmentObject(navigationModel)
        }
    }
}
