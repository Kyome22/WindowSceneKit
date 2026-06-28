/*
 WindowSceneModifier.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

@MainActor struct WindowSceneModifier<Payload: Sendable>: @preconcurrency _SceneModifier {
    @State private var sceneRepresentable: WindowSceneRepresentable
    @Binding private var isPresented: Bool
    private var key: WindowSceneKey<Payload>
    private var window: (Payload?) -> NSWindow

    init(isPresented: Binding<Bool>, key: WindowSceneKey<Payload>, window: @escaping (Payload?) -> NSWindow) {
        sceneRepresentable = .init(closeAction: { isPresented.wrappedValue = false })
        _isPresented = isPresented
        self.key = key
        self.window = window
    }

    func body(content: SceneContent) -> some Scene {
        content.onChange(of: isPresented, initial: true) { _, newValue in
            if newValue {
                let payload = WindowStateStore.payloads[key.id] as? Payload
                sceneRepresentable.open(window: window(payload))
            } else {
                sceneRepresentable.close()
                WindowStateStore.payloads.removeValue(forKey: key.id)
            }
        }
    }
}
