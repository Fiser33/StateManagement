//
//  NavigationModel.swift
//  StateManagement
//
//  Created by Fišer Jakub on 21.02.2023.
//

import SwiftUI

class NavigationModel: ObservableObject {
    @Published var path: NavigationPath = .init()
}
