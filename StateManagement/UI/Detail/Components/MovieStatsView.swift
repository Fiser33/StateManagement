//
//  MovieStatsView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 24.02.2023.
//

import SwiftUI

struct MovieStatsView: View {
    let movie: Movie

    let titleLabelColor = Color.secondary

    var body: some View {
        Grid {
            getDateRow(title: "Release date", value: movie.releaseDate)

            Divider()

            getSimpleRow(title: "Genres", value: movie.genres?.map(\.name).joined(separator:  " | "))

            Divider()

            getCurrencyRow(title: "Budget", value: movie.budget)

            Divider()

            getCurrencyRow(title: "Revenue", value: movie.revenue)
        }
    }

    func getSimpleRow(title: String, value: String?) -> some View {
        getGeneralRow(title: title) {
            Text(value ?? "")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    func getDateRow(title: String, value: Date?) -> some View {
        getGeneralRow(title: title) {
            Group {
                if let value {
                    Text(value, style: .date)
                } else {
                    Text("N/A")
                }
            }
        }
    }

    func getCurrencyRow(title: String, value: Double?) -> some View {
        getGeneralRow(title: title) {
            CurrencyLabelView(value: value)
        }
    }

    func getGeneralRow<Content: View>(title: String, content: () -> Content) -> some View {
        GridRow {
            Text("\(title):")
                .gridColumnAlignment(.leading)
                .foregroundColor(titleLabelColor)

            content()
                .gridColumnAlignment(.trailing)
        }
    }
}

struct MovieStatsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieStatsView(movie: .blackPantherMock)
            .injectMockEnvironment()
    }
}
