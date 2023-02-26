//
//  MovieHeaderView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 13.02.2023.
//

import SwiftUI

struct MovieHeaderView: View {
    @Binding var isFavourite: Bool

    let movie: Movie

    let titleStatsSpacing: Double = 16

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.primary.opacity(0.2)

            HStack(alignment: .bottom, spacing: 16) {
                PlaceholderAsyncImage(url: movie.posterPath, contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .clipped()

                VStack(alignment: .trailing, spacing: titleStatsSpacing) {
                    PopularityGadgetView(popularity: movie.popularityPercentage, size: .large)

                    MovieHeaderStatsFavouriteView(
                        isFavourite: $isFavourite,
                        duration: movie.runtime,
                        popularity: movie.popularityPercentage
                    )
                }
                .foregroundColor(Color.primary)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .frame(height: 356)
        .background(alignment: .top) {
            PlaceholderAsyncImage(url: movie.backdropPath, contentMode: .fill)
                .blur(radius: 2)
                .frame(height: 300)
        }
    }
}

struct MovieHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHeaderView(isFavourite: .constant(true), movie: .blackPantherMock)
    }
}
