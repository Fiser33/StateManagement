//
//  CollectionScreenView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 07.02.2023.
//

import SwiftUI

struct CollectionScreenView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @StateObject var model: CollectionViewModel = .init()

    @State var layoutMode: LayoutMode = .regular

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
                            navigationModel.path.append(Route.detail(movie))
                        }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .task {
            await model.loadItems()
        }
        .navigationTitle("Movies")
        .toolbar {
            Button(action: {
                withAnimation {
                    layoutMode = layoutMode.oposite
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
