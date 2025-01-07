/*
 WindowStateStore.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI
import Observation

@MainActor @Observable final class WindowStateStore {
    static var supplements = [String: any Sendable]()

    var windowKey: String
    var isPresented: Bool

    init(windowKey: String, isPresented: Bool) {
        self.windowKey = windowKey
        self.isPresented = isPresented
        // The WindowStateStore and App lifecycles are the same.
        Task {
            for await notification in NotificationCenter.default.publisher(for: .didRequestWindowAction).values {
                guard let userInfo = notification.userInfo,
                      let windowKey = userInfo["windowKey"] as? String,
                      let windowAction = userInfo["windowAction"] as? WindowAction,
                      let supplements = userInfo["supplements"] as? Supplements,
                      windowKey == self.windowKey else {
                    continue
                }
                if windowAction.isOpen {
                    Self.supplements = supplements.value
                }
                self.isPresented = windowAction.isOpen
            }
        }
    }
}
