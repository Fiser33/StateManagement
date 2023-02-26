//
//  RecommendedMoviesListView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 24.02.2023.
//

import SwiftUI

struct RecommendedMoviesListView: View {
    @EnvironmentObject var navigationModel: NavigationModel

    let movies: [Movie]?

    var body: some View {
        Group {
            if let movies {
                getScrollView(movies: movies)
            } else {
                emptyView
            }
        }
        .frame(height: 200)
    }

    var emptyView: some View {
        HStack {
            ProgressView()

            Spacer()
        }
        .padding(.horizontal)
    }

    func getScrollView(movies: [Movie]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(movies) { movie in
                    CollectionMovieItemView(movie: movie)
                        .frame(width: 100)
                        .onTapGesture {
                            navigationModel.path.append(Route.detail(movie))
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MovieCastView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RecommendedMoviesListView(movies: nil)

            RecommendedMoviesListView(movies: Movie.randomItems(length: 20))
        }
        .injectMockEnvironment()
    }
}
