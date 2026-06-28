/*
 WindowSceneKey.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2026/06/28.

*/

public struct WindowSceneKey<Payload: Sendable>: Sendable {
    public let id: String

    public init(_ id: String) {
        self.id = id
    }
}
