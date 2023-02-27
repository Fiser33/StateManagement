//
//  MovieDetailScreenView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 13.02.2023.
//

import SwiftUI

struct MovieDetailScreenView: View {
    @EnvironmentObject var appState: AppStateStore
    @StateObject var model: MovieDetailViewModel

    var movieTitle: String {
        let originalTitle = model.movie.originalTitle ?? model.movie.title
        return appState.showOriginalTitle ? originalTitle : model.movie.title
    }

    init(movie: Movie) {
        _model = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
    }

    var body: some View {
        ScrollView {
            MovieHeaderView(isFavourite: $model.isFavourite, movie: model.movie)

            Text(model.movie.overview ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .top])

            MovieStatsView(movie: model.movie)
                .padding()

            Text("Recommended movies:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .top])

            RecommendedMoviesListView(movies: model.recommendedMovies)

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(movieTitle)
        .task { await model.loadData() }
    }
}

struct MovieDetailScreenView_Previews: PreviewProvider {
    static func withDependencies<T: View>(_ content: @escaping () -> T) -> T {
        DependencyContainer.apiRepository.register {
            let repository = ApiRepositoryMock()
            repository.getRecommendedMoviesResult = Movie.randomItems(length: 10)
            return repository
        }
        DependencyContainer.localStorageRepository.register { LocalStorageRepositoryMock() }
        return content()
    }

    static var previews: some View {
        withDependencies() {
            MovieDetailScreenView(movie: .blackPantherMock)
        }
        .injectMockEnvironment()
    }
}
