/*
 WindowSceneModifier.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

@MainActor struct WindowSceneModifier: @preconcurrency _SceneModifier {
    @State var sceneRepresentable: WindowSceneRepresentable
    @Binding var isPresented: Bool
    var window: () -> NSWindow

    init(isPresented: Binding<Bool>, window: @escaping () -> NSWindow) {
        sceneRepresentable = .init(closeAction: {
            isPresented.wrappedValue = false
        })
        _isPresented = isPresented
        self.window = window
    }

    func body(content: SceneContent) -> some Scene {
        content.onChange(of: isPresented, initial: true) { _, newValue in
            if newValue {
                sceneRepresentable.open(window: window)
            } else {
                sceneRepresentable.close()
            }
        }
    }
}
