//
//  MovieTitleLabel.swift
//  StateManagement
//
//  Created by Fišer Jakub on 21.02.2023.
//

import SwiftUI

struct MovieTitleLabel: View {
    @EnvironmentObject var appState: AppStateStore

    let movie: Movie

    var movieTitle: String {
        let originalTitle = movie.originalTitle ?? movie.title
        return appState.showOriginalTitle ? originalTitle : movie.title
    }

    var body: some View {
        Text(movieTitle)
    }
}

struct MovieTitleLabel_Previews: PreviewProvider {
    static var previews: some View {
        MovieTitleLabel(movie: .blackPantherMock)
            .environmentObject(AppStateStore())
    }
}
