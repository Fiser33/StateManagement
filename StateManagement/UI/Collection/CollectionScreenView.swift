//
//  CollectionScreenView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 07.02.2023.
//

import SwiftUI

struct CollectionScreenView: View {
    var navigationModel: NavigationModel = .init()
    var model: CollectionViewModel = .init()

    var layoutMode: LayoutMode = .regular

    var columns: [GridItem] {
        Array(repeating: GridItem(), count: layoutMode.numberOfColumns)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(model.movies) { movie in
                    CollectionMovieItemView(movie: movie)
                        .aspectRatio(0.5, contentMode: .fit)
                        .onTapGesture {
                            // TODO: Push to navigation
                        }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .task {
            // TODO: Load data
        }
        .navigationTitle("Movies")
        .toolbar {
            Button(action: {
                withAnimation {
                    // TODO: Change layout
                }
            }) {
                Image(systemName: "square.grid.\(layoutMode.oposite.numberOfColumns)x3.fill")
            }
        }
    }

    enum LayoutMode: Int {
        case regular = 3
        case compact = 4

        var numberOfColumns: Int { rawValue }

        var oposite: LayoutMode {
            switch self {
            case .regular: return .compact
            case .compact: return .regular
            }
        }
    }
}

struct CollectionScreenView_Previews: PreviewProvider {
    static func withDependencies<T: View>(_ content: @escaping () -> T) -> T {
        DependencyContainer.apiRepository.register {
            let mock = ApiRepositoryMock()
            mock.getMoviesResult = Movie.randomItems(length: 29)
            return mock
        }
        return content()
    }

    static var previews: some View {
        withDependencies() {
            CollectionScreenView()
        }
        .injectMockEnvironment()
    }
}
