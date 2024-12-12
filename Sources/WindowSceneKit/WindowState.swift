/*
 WindowState.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

@MainActor @propertyWrapper public struct WindowState: DynamicProperty, Sendable {
    @State var store: WindowStateStore

    public var wrappedValue: Bool {
        get { store.isPresented }
        nonmutating set { store.isPresented = newValue }
    }

    public var projectedValue: Binding<Bool> {
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    public init(wrappedValue: Bool, _ windowKey: String) {
        store = .init(windowKey: windowKey, isPresented: wrappedValue)
    }
}
