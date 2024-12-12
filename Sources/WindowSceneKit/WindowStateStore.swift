/*
 WindowStateStore.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI
import Observation

@MainActor @Observable final class WindowStateStore {
    @ObservationIgnored private var task: Task<Void, Never>?
    var windowKey: String
    var isPresented: Bool

    init(windowKey: String, isPresented: Bool) {
        self.windowKey = windowKey
        self.isPresented = isPresented
        task = Task {
            for await notification in NotificationCenter.default.publisher(for: .didRequestWindowAction).values {
                guard let userInfo = notification.userInfo,
                      let windowKey = userInfo["windowKey"] as? String,
                      let windowAction = userInfo["windowAction"] as? WindowAction,
                      windowKey == self.windowKey else {
                    continue
                }
                self.isPresented = windowAction.isOpen
            }
        }
    }

    deinit {
        task?.cancel()
    }
}
