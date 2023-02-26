//
//  ModelExtensions.swift
//  StateManagement
//
//  Created by Fišer Jakub on 24.02.2023.
//

import Foundation

extension Movie {
    var popularityPercentage: Double? {
        voteAverage.map({ $0 / 10 })
    }
}
