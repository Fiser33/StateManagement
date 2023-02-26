//
//  PreviewExtensions.swift
//  StateManagement
//
//  Created by Fišer Jakub on 24.02.2023.
//

import SwiftUI

extension View {
    func injectMockEnvironment() -> some View {
        self
            .environmentObject(AppStateStore())
            .environmentObject(NavigationModel())
    }
}
