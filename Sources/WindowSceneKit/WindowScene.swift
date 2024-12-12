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
