//
//  MovieDetailViewModel.swift
//  StateManagement
//
//  Created by Fišer Jakub on 13.02.2023.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Dependency(DependencyContainer.apiRepository) var apiRepository: ApiRepository
    @Dependency(DependencyContainer.localStorageRepository) var localStorageRepository: LocalStorageRepository
    
    @Published var movie: Movie
    @Published var recommendedMovies: [Movie]?
    @Published var error: Error?
    @Published var isFavourite: Bool = false {
        didSet {
            localStorageRepository.setFavourite(movie: movie, favourite: isFavourite)
        }
    }

    init(movie: Movie) {
        self.movie = movie
        self.isFavourite = localStorageRepository.isFavourite(movie: movie)
    }

    func loadData() async {
        await loadMovieDetails()
        await loadRecommendedMovies()
    }
}

extension MovieDetailViewModel {
    private func loadMovieDetails() async {
        do {
            let backdropPath = try? await apiRepository.getBackdropPath(for: movie)
            let posterPath = try? await apiRepository.getPosterPath(for: movie)
            let movie = (try await apiRepository.getMovieDetail(for: movie)).withFullPaths(posterPath: posterPath, backdropPath: backdropPath)
            await MainActor.run {
                self.movie = movie
            }
        } catch {
            self.error = error
        }
    }

    private func loadRecommendedMovies() async {
        guard let moviesRaw = try? await apiRepository.getRecommendedMovies(for: movie) else { return }
        await MainActor.run {
            self.recommendedMovies = moviesRaw
        }

        var movies: [Movie] = []
        for movie in moviesRaw {
            let posterPath = try? await apiRepository.getPosterPath(for: movie)
            movies.append(movie.withFullPaths(posterPath: posterPath))
        }
        await MainActor.run { [movies] in
            self.recommendedMovies = movies
        }
    }
}
