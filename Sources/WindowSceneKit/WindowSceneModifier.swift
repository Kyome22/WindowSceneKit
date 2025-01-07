/*
 WindowSceneModifier.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

@MainActor struct WindowSceneModifier: @preconcurrency _SceneModifier {
    @State private var sceneRepresentable: WindowSceneRepresentable
    @Binding private var isPresented: Bool
    private var window: ([String: any Sendable]) -> NSWindow

    init(isPresented: Binding<Bool>, window: @escaping ([String: any Sendable]) -> NSWindow) {
        sceneRepresentable = .init(closeAction: { isPresented.wrappedValue = false })
        _isPresented = isPresented
        self.window = window
    }

    func body(content: SceneContent) -> some Scene {
        content.onChange(of: isPresented, initial: true) { _, newValue in
            if newValue {
                sceneRepresentable.open(window: window(WindowStateStore.supplements))
            } else {
                sceneRepresentable.close()
                WindowStateStore.supplements.removeAll()
            }
        }
    }
}
