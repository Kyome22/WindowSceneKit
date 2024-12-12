/*
 WindowSceneRepresentable.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

@MainActor final class WindowSceneRepresentable: NSObject, NSWindowDelegate {
    var window: NSWindow?
    var closeAction: () -> Void

    init(closeAction: @escaping () -> Void) {
        self.closeAction = closeAction
    }

    func open(window instance: @escaping () -> NSWindow) {
        guard window == nil else { return }
        window = instance()
        window?.isReleasedWhenClosed = false
        window?.delegate = self
        window?.center()
        window?.orderFrontRegardless()
    }

    func close() {
        window?.close()
    }

    func windowWillClose(_ notification: Notification) {
        if let _window = notification.object as? NSWindow, _window === window {
            window = nil
            closeAction()
        }
    }
}
