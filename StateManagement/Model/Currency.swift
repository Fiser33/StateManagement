//
//  Currency.swift
//  StateManagement
//
//  Created by Fišer Jakub on 21.02.2023.
//

import Foundation

enum Currency: String, CaseIterable {
    case usd
    case eur
    case czk

    var id: String { rawValue }

    var title: String {
        "\(sign) (\(id.uppercased()))"
    }

    var conversionRate: Double {
        switch self {
        case .usd: return 1.0
        case .eur: return 0.94
        case .czk: return 22.31
        }
    }

    var sign: String {
        switch self {
        case .usd: return "$"
        case .eur: return "€"
        case .czk: return "Kč"
        }
    }
}
