//
//  LocalStorageRepository.swift
//  StateManagement
//
//  Created by Fišer Jakub on 21.02.2023.
//

import Foundation

protocol LocalStorageRepository {
    var hasAnyFavouriteMovie: Bool { get }
    func isFavourite(movie: Movie) -> Bool
    func setFavourite(movie: Movie, favourite: Bool)
    func clearFavourites()

    var currency: Currency? { get set }
    var showOriginalTitle: Bool? { get set }
}

class LocalStorageRepositoryImpl: LocalStorageRepository {
    let store = UserDefaults.standard

    var currency: Currency? {
        get { Currency(rawValue: store.string(forKey: UserDefaultKeys.currency.key) ?? "") }
        set { store.set(newValue?.rawValue, forKey: UserDefaultKeys.currency.key) }
    }
    var showOriginalTitle: Bool? {
        get { store.bool(forKey: UserDefaultKeys.showOriginalTitle.key) }
        set { store.set(newValue, forKey: UserDefaultKeys.showOriginalTitle.key) }
    }

    var hasAnyFavouriteMovie: Bool { !favourites.isEmpty }
    var favourites: Set<Int> = [] {
        didSet {
            store.set(Array(favourites), forKey: UserDefaultKeys.favourites.key)
        }
    }

    init() {
        favourites = Set(store.array(forKey: UserDefaultKeys.favourites.key) as? [Int] ?? [])
    }

    func isFavourite(movie: Movie) -> Bool {
        favourites.contains(movie.id)
    }

    func setFavourite(movie: Movie, favourite: Bool) {
        if favourite {
            favourites.insert(movie.id)
        } else {
            favourites.remove(movie.id)
        }
    }

    func clearFavourites() {
        favourites.removeAll()
    }

    enum UserDefaultKeys: String {
        case favourites
        case currency
        case showOriginalTitle

        var key: String { rawValue }
    }
}

// Mock implementation for SwiftUI previews
class LocalStorageRepositoryMock: LocalStorageRepository {
    var currency: Currency?
    var showOriginalTitle: Bool?
    var favourites: Set<Int> = []

    var hasAnyFavouriteMovie: Bool { !favourites.isEmpty }
    func isFavourite(movie: Movie) -> Bool {
        favourites.contains(movie.id)
    }

    func setFavourite(movie: Movie, favourite: Bool) {
        if favourite {
            favourites.insert(movie.id)
        } else {
            favourites.remove(movie.id)
        }
    }

    func clearFavourites() {
        favourites.removeAll()
    }
}
