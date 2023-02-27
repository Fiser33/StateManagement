//
//  MovieHeaderStatsFavouriteView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 13.02.2023.
//

import SwiftUI

struct MovieHeaderStatsFavouriteView: View {
    var isFavourite: Bool

    let duration: Int?
    let popularity: Double?

    var dividerView: some View {
        Divider().frame(maxHeight: 40)
    }

    var durationString: String {
        guard let duration else { return "N/A" }
        var result = ""
        let hours = duration / 60
        let minutes = duration - (hours * 60)
        if hours > 0 {
            result += "\(hours)h"
        }
        if minutes > 0 {
            let separator = result.isEmpty ? "" : " "
            result += "\(separator)\(minutes)m"
        }
        return result
    }

    var popularityString: String {
        guard let popularity else { return "N/A" }
        return "\(Int(round(popularity * 100))) %"
    }

    var body: some View {
        HStack {
            MovieStateItemView(icon: "clock", text: durationString)
                .frame(maxWidth: .infinity)

            dividerView

            MovieStateItemView(icon: "hand.thumbsup", text: popularityString)
                .frame(maxWidth: .infinity)

            dividerView

            Button(action: {
                // TODO: Store to favourites
            }) {
                Image(systemName: isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(isFavourite ? Color.purple : .primary)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct MovieHeaderStatsFavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHeaderStatsFavouriteView(isFavourite: true, duration: 90, popularity: 0.75)
    }
}
