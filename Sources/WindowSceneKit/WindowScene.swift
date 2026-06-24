/*
 WindowScene.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

public struct WindowScene: Scene {
    @Binding private var isPresented: Bool
    private var window: ([String: any Sendable]) -> NSWindow

    public init(isPresented: Binding<Bool>, window: @escaping (_ supplements: [String: any Sendable]) -> NSWindow) {
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
