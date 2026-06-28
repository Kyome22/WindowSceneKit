/*
 WindowStateStore.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI
import Observation

@MainActor @Observable final class WindowStateStore {
    static var payloads = [String: Any]()

    var windowKey: String
    var isPresented: Bool

    init(windowKey: String, isPresented: Bool) {
        self.windowKey = windowKey
        self.isPresented = isPresented
        // The WindowStateStore and App lifecycles are the same.
        Task {
            let publisher = NotificationCenter.default.publisher(for: .didRequestWindowAction)
            for await notification in publisher.bufferedValues() {
                guard let userInfo = notification.userInfo,
                      let windowKey = userInfo["windowKey"] as? String,
                      let windowAction = userInfo["windowAction"] as? WindowAction,
                      windowKey == self.windowKey else {
                    continue
                }
                if windowAction.isOpen {
                    Self.payloads[windowKey] = userInfo["payload"]
                }
                self.isPresented = windowAction.isOpen
            }
        }
    }
}
