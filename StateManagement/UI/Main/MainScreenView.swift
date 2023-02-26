//
//  MainScreenView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 07.02.2023.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject var appState: AppStateStore

    init() {
        _appState = StateObject(wrappedValue: DependencyContainer.appStateStore.callAsFunction())
    }

    var body: some View {
        TabView {
            NavigationStackWrapper(root: .collection)
                .tabItem {
                    Label("Movies", systemImage: "video")
                }

            NavigationStackWrapper(root: .settings)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .environmentObject(appState)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static func withDependencies<T: View>(_ content: @escaping () -> T) -> T {
        DependencyContainer.apiRepository.register {
            let mock = ApiRepositoryMock()
            mock.getMoviesResult = Movie.randomItems(length: 29)
            return mock
        }
        DependencyContainer.localStorageRepository.register { LocalStorageRepositoryMock() }
        return content()
    }

    static var previews: some View {
        withDependencies() {
            MainScreenView()
        }
    }
}
