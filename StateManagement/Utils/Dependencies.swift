//
//  Dependencies.swift
//  StateManagement
//
//  Created by Fišer Jakub on 08.02.2023.
//

import Factory

typealias Dependency = Injected
typealias DependencyContainer = Container

extension Container {
    static let apiRepository = Factory { ApiRepositoryImpl(apiKey: Secrets.tmdbApiKey) as ApiRepository }
    static let localStorageRepository = Factory { LocalStorageRepositoryImpl() as LocalStorageRepository }
    static let appStateStore = Factory { AppStateStore() }
}
