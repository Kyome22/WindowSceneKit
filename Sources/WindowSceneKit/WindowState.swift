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

    public init<Payload: Sendable>(wrappedValue: Bool, _ key: WindowSceneKey<Payload>) {
        store = .init(windowKey: key.id, isPresented: wrappedValue)
    }
}
