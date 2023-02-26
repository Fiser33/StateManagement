//
//  PlaceholderAsyncImage.swift
//  StateManagement
//
//  Created by Fišer Jakub on 13.02.2023.
//

import SwiftUI

struct PlaceholderAsyncImage: View {
    let url: URL?
    var contentMode: ContentMode = .fit

    var body: some View {
        AsyncImage(
            url: url,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            },
            placeholder: {
                Color.primary.opacity(0.5)
                    .overlay(Image(systemName: "photo"))
            }
        )
    }
}

struct PlaceholderAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderAsyncImage(url: Movie.blackPantherMock.posterPath)
    }
}
