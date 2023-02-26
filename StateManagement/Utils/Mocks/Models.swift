//
//  Models.swift
//  StateManagement
//
//  Created by Fišer Jakub on 07.02.2023.
//

import Foundation

extension Movie {
    func withFullPaths(posterPath: URL?, backdropPath: URL? = nil) -> Movie {
        .init(
            id: id,
            title: title,
            tagline: tagline,
            originalTitle: originalTitle,
            originalLanguage: originalLanguage,
            overview: overview,
            runtime: runtime,
            genres: genres,
            releaseDate: releaseDate,
            posterPath: posterPath ?? self.posterPath,
            backdropPath: backdropPath ?? self.backdropPath,
            budget: budget,
            revenue: revenue,
            status: status,
            productionCompanies: productionCompanies,
            productionCountries: productionCountries,
            spokenLanguages: spokenLanguages,
            popularity: popularity,
            voteAverage: voteAverage,
            voteCount: voteCount,
            video: video,
            adult: adult
        )
    }
}

extension Movie {
    static var blackPantherMock: Movie {
        .init(
            id: 505642,
            title: "Black Panther: Wakanda nechť žije",
            tagline: nil,
            originalTitle: "Black Panther: Wakanda Forever",
            originalLanguage: "en",
            overview: "Královna Ramonda, Shuri, M’Baku, Okoye a Dora Milaje bojují o ochranu svého národa před zasahujícími světovými mocnostmi poté, co se rozšířily zprávy o smrti krále T’Chally. Zatímco se obyvatelé Wakandy snaží přijmout svou další kapitolu, hrdinové se musí spojit a s pomocí Nakii a Everetta Rosse vytvořit nový svět pro království Wakanda.",
            runtime: nil,
            genres: nil,
            releaseDate: Date(),
            posterPath: URL(string: "https://image.tmdb.org/t/p/w300/ctfG7NmFtbqCnqJ06T9kqsgfDM3.jpg"),
            backdropPath: URL(string: "https://image.tmdb.org/t/p/w300/xDMIl84Qo5Tsu62c9DGWhmPI67A.jpg"),
            budget: 1_000_000,
            revenue: 12_345_678,
            status: nil,
            productionCompanies: nil,
            productionCountries: nil,
            spokenLanguages: nil,
            popularity: 7895.146,
            voteAverage: 7.5,
            voteCount: 2963,
            video: false,
            adult: false
        )
    }

    static var randomMock: Movie {
        .init(
            id: .random(in: Int.min...Int.max),
            title: .randomString(length: Int.random(in: 4...25)),
            tagline: nil,
            originalTitle: nil,
            originalLanguage: nil,
            overview: nil,
            runtime: nil,
            genres: nil,
            releaseDate: nil,
            posterPath: nil,
            backdropPath: nil,
            budget: nil,
            revenue: nil,
            status: nil,
            productionCompanies: nil,
            productionCountries: nil,
            spokenLanguages: nil,
            popularity: nil,
            voteAverage: nil,
            voteCount: nil,
            video: nil,
            adult: nil
        )
    }

    static func randomItems(length: Int) -> [Movie] {
        (1...length).map({ _ in Movie.randomMock })
    }
}

extension String {
    static func randomString(length: Int) -> String {
        // Should perform twice as better using Array instead of just String
        let letters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
