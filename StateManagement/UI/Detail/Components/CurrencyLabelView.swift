//
//  CurrencyLabelView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 21.02.2023.
//

import SwiftUI

struct CurrencyLabelView: View {
    @EnvironmentObject var appState: AppStateStore

    let value: Double?

    var body: some View {
        Text(appState.getCurrencyLabel(value))
    }
}

struct CurrencyLabelView_Previews: PreviewProvider {
    static func withDependencies<T: View>(_ content: @escaping () -> T) -> T {
        DependencyContainer.localStorageRepository.register { LocalStorageRepositoryMock() }
        return content()
    }

    static func createAppState(currency: Currency) -> AppStateStore {
        let store = AppStateStore()
        store.currency = currency
        return store
    }

    static var previews: some View {
        withDependencies() {
            VStack(spacing: 20) {
                CurrencyLabelView(value: nil)
                    .environmentObject(createAppState(currency: .usd))

                CurrencyLabelView(value: 123_456)
                    .environmentObject(createAppState(currency: .usd))

                CurrencyLabelView(value: 123_456)
                    .environmentObject(createAppState(currency: .czk))
            }
        }
    }
}
