//
//  CollectionMovieItemView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 08.02.2023.
//

import SwiftUI

struct CollectionMovieItemView: View {
    let movie: Movie

    let padding: Double = 3
    let titleLabelHeight: Double = 40

    var body: some View {
        VStack {
            Color.clear
                .overlay(alignment: .top) {
                    PlaceholderAsyncImage(url: movie.posterPath)
                        .scaledToFill()
                }
                .clipped()
                .overlay(alignment: .bottomTrailing) {
                    PopularityGadgetView(popularity: movie.popularityPercentage)
                        .padding(4)
                }
                .shadow(color: Color.purple.opacity(0.75), radius: 4)

            MovieTitleLabel(movie: movie)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundColor(Color.primary)
                .font(.caption)
                .padding(.top, padding)
                .frame(maxWidth: .infinity)
                .frame(height: titleLabelHeight, alignment: .top)
        }
    }
}

struct CollectionMovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionMovieItemView(movie: .blackPantherMock)
            .frame(width: 100, height: 200)
            .previewLayout(.sizeThatFits)
            .injectMockEnvironment()
    }
}
