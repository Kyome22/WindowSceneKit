/*
 WindowScene.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

public struct WindowScene<Payload: Sendable>: Scene {
    @Binding private var isPresented: Bool
    private var key: WindowSceneKey<Payload>
    private var window: (Payload?) -> NSWindow

    public init(
        isPresented: Binding<Bool>,
        key: WindowSceneKey<Payload>,
        window: @escaping (_ payload: Payload?) -> NSWindow
    ) {
        _isPresented = isPresented
        self.key = key
        self.window = window
    }

    public var body: some Scene {
        ModifiedContent(
            content: _EmptyScene(),
            modifier: WindowSceneModifier(isPresented: $isPresented, key: key, window: window)
        )
    }
}
