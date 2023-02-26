//
//  MovieCastListView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 24.02.2023.
//

import SwiftUI

struct MovieCastListView: View {
    let castMembers: [CastMember]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(castMembers) { member in
                    getMemberView(castMember: member)
                }
            }
        }
    }

    func getMemberView(castMember: CastMember) -> some View {
        VStack {
            Color.gray
                .overlay {
                    PlaceholderAsyncImage(url: castMember.profilePath)
                }
                .clipShape(Circle())
                .frame(height: 100)

            Text(castMember.name)
                .font(.caption)

            Text(castMember.character)
                .font(.caption2)

            Spacer()
        }
        .frame(width: 100, height: 140)
    }
}

struct MovieCastView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCastListView(castMembers: (1...20).map({ _ in CastMember.random }))
    }
}
