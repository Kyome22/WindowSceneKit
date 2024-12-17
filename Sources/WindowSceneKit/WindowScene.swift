/*
 WindowScene.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI
import Observation

public struct WindowScene: Scene {
    @Binding var isPresented: Bool
    var window: () -> NSWindow

    public init(isPresented: Binding<Bool>, window: @autoclosure @escaping () -> NSWindow) {
        _isPresented = isPresented
        self.window = window
    }

    public var body: some Scene {
        ModifiedContent(
            content: _EmptyScene(),
            modifier: WindowSceneModifier(isPresented: $isPresented, window: window)
        )
    }
}

struct MyScene: Scene {
    @Binding var isPresented: Bool

    var body: some Scene {
        ModifiedContent(
            content: _EmptyScene(),
            modifier: MySceneModifier(isPresented: $isPresented)
        )
    }
}

@MainActor struct MySceneModifier: @preconcurrency _SceneModifier {
    @State private var sceneRepresentable = MySceneRepresentable()
    @Binding var isPresented: Bool

    init(isPresented: Binding<Bool>) {
        _isPresented = isPresented
    }

    func body(content: SceneContent) -> some Scene {
        content.onChange(of: isPresented, initial: true) { _, newValue in
            if newValue {
                sceneRepresentable.open()
            } else {
                sceneRepresentable.close()
            }
        }
    }
}

@MainActor class MySceneRepresentable {
    var window: NSWindow?

    func open() {
        guard window == nil else { return }
        window = NSWindow()
        window?.orderFrontRegardless()
    }

    func close() {
        window?.close()
    }
}
