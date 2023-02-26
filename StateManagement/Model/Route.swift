//
//  Route.swift
//  StateManagement
//
//  Created by Fišer Jakub on 21.02.2023.
//

import SwiftUI

enum Route: Hashable {
    case collection
    case detail(Movie)
    case settings

    var view: any View {
        switch self {
        case .collection:
            return CollectionScreenView()
        case let .detail(movie):
            return MovieDetailScreenView(movie: movie)
        case .settings:
            return SettingsScreenView()
        }
    }
}
