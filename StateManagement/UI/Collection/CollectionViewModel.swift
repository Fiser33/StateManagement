//
//  CollectionViewModel.swift
//  StateManagement
//
//  Created by Fišer Jakub on 07.02.2023.
//

import Foundation

class CollectionViewModel: ObservableObject {
    @Dependency(DependencyContainer.apiRepository) var apiRepository: ApiRepository

    @Published var movies: [Movie] = []
    @Published var error: Error?

    func loadItems() async {
        do {
            let movies = try await apiRepository.getMovies()
            await MainActor.run {
                self.movies = movies
            }

            await loadPosters()
        } catch {
            self.error = error
        }
    }

    func loadPosters() async {
        for index in movies.indices {
            let movie = movies[index]
            if let posterPath = try? await apiRepository.getPosterPath(for: movie) {
                await MainActor.run {
                    self.movies[index] = movie.withFullPaths(posterPath: posterPath)
                }
            }
        }
    }
}
