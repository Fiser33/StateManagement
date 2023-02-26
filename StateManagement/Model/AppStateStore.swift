//
//  AppStateStore.swift
//  StateManagement
//
//  Created by Fišer Jakub on 21.02.2023.
//

import Foundation

class AppStateStore: ObservableObject {
    @Dependency(DependencyContainer.localStorageRepository) var localStorageRepository: LocalStorageRepository

    @Published var currency: Currency = .usd {
        didSet {
            localStorageRepository.currency = currency
        }
    }
    @Published var showOriginalTitle: Bool = false {
        didSet {
            localStorageRepository.showOriginalTitle = showOriginalTitle
        }
    }

    init() {
        currency = localStorageRepository.currency ?? currency
        showOriginalTitle = localStorageRepository.showOriginalTitle ?? showOriginalTitle
    }

    func getCurrencyLabel(_ value: Double?) -> String {
        guard let value else { return "N/A" }
        let valueConverted = Int(floor(value * currency.conversionRate))
        return "\(valueConverted) \(currency.sign)"
    }
}
