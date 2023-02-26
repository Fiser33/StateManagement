//
//  MovieStateItemView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 20.02.2023.
//

import SwiftUI

struct MovieStateItemView: View {
    let icon: String
    let text: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)

            Text(text)
                .font(.caption)
        }
    }
}

struct MovieStateItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieStateItemView(icon: "hand.thumbsup", text: "75 %")
    }
}
