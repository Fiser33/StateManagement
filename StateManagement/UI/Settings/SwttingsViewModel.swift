//
//  SwttingsViewModel.swift
//  StateManagement
//
//  Created by Fišer Jakub on 21.02.2023.
//

import Foundation

class SwttingsViewModel: ObservableObject {
    @Dependency(DependencyContainer.localStorageRepository) var localStorageRepository: LocalStorageRepository

    @Published var clearFavouritesEnabled: Bool = true

    init() {
        clearFavouritesEnabled = localStorageRepository.hasAnyFavouriteMovie
    }

    func clearAllFavourites() {
        localStorageRepository.clearFavourites()
        clearFavouritesEnabled = false
    }
}
