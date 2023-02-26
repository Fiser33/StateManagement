//
//  ApiRepository.swift
//  StateManagement
//
//  Created by Fišer Jakub on 07.02.2023.
//

import Foundation
import TMDb

// Type erasure of api objects to avoid repetitive import. Can be also done by creating custom model objects.
typealias Movie = TMDb.Movie

// Protocol
protocol ApiRepository {
    func getMovies() async throws -> [Movie]
    func getMovieDetail(for: Movie) async throws -> Movie
    func getRecommendedMovies(for movie: Movie) async throws -> [Movie]

    func getBackdropPath(for: Movie) async throws -> URL?
    func getPosterPath(for: Movie) async throws -> URL?
    func getProfilePath(for castMember: CastMember) async throws -> URL?
}

// Actual implementation
class ApiRepositoryImpl: ApiRepository {
    let client: TMDbAPI

    init(apiKey: String) {
        client = TMDbAPI(apiKey: apiKey)
    }

    func getMovies() async throws -> [Movie] {
        try await client.discover.movies().results
    }

    func getMovieDetail(for movie: Movie) async throws -> Movie {
        try await client.movies.details(forMovie: movie.id)
    }

    func getRecommendedMovies(for movie: Movie) async throws -> [Movie] {
        try await client.movies.recommendations(forMovie: movie.id, page: 1).results
    }

    func getBackdropPath(for movie: Movie) async throws -> URL? {
        guard let path = movie.backdropPath else { return nil }
        let config = try await client.configurations.apiConfiguration()
        return config.images.backdropURL(for: path, idealWidth: 400)
    }

    func getPosterPath(for movie: Movie) async throws -> URL? {
        guard let path = movie.posterPath else { return nil }
        let config = try await client.configurations.apiConfiguration()
        return config.images.posterURL(for: path, idealWidth: 200)
    }

    func getProfilePath(for castMember: CastMember) async throws -> URL? {
        guard let path = castMember.profilePath else { return nil }
        let config = try await client.configurations.apiConfiguration()
        return config.images.profileURL(for: path, idealWidth: 100)
    }
}

// Mock implementation for SwiftUI previews
class ApiRepositoryMock: ApiRepository {
    var getMoviesResult: [Movie] = []
    func getMovies() async throws -> [Movie] { getMoviesResult }
    func getMovieDetail(for movie: Movie) async throws -> Movie { movie }
    var getRecommendedMoviesResult: [Movie] = []
    func getRecommendedMovies(for movie: Movie) async throws -> [Movie] { getRecommendedMoviesResult }

    func getBackdropPath(for movie: Movie) async throws -> URL? { return nil }
    func getPosterPath(for movie: Movie) async throws -> URL? { return nil }
    func getProfilePath(for castMember: CastMember) async throws -> URL? { return nil }
}
