//
//  SettingsScreenView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 21.02.2023.
//

import SwiftUI

struct SettingsScreenView: View {
    @EnvironmentObject var appState: AppStateStore
    @StateObject var model: SwttingsViewModel = .init()

    var body: some View {
        List {
            Section("Customize") {
                Picker("Currency", selection: $appState.currency) {
                    ForEach(Currency.allCases, id: \.id) { currency in
                        Text(currency.title).tag(currency)
                    }
                }

                Toggle("Show original title", isOn: $appState.showOriginalTitle)
            }

            Section("Data") {
                Button(role: .destructive, action: model.clearAllFavourites) {
                    Text("Clear all favourites")
                }
                .disabled(!model.clearFavouritesEnabled)
            }
        }
        .navigationTitle("Settings")
    }
}

struct SwttingsScreenView_Previews: PreviewProvider {
    static func withDependencies<T: View>(_ content: @escaping () -> T) -> T {
        DependencyContainer.localStorageRepository.register { LocalStorageRepositoryMock() }
        return content()
    }

    static var previews: some View {
        withDependencies() {
            SettingsScreenView()
                .environmentObject(AppStateStore())
        }
    }
}
