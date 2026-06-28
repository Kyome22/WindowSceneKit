/*
 WindowSceneMessenger.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

public struct WindowSceneMessenger {
    public static func request<Payload: Sendable>(
        _ windowAction: WindowAction,
        for key: WindowSceneKey<Payload>,
        payload: Payload? = nil
    ) {
        var userInfo: [AnyHashable: Any] = [
            "windowKey": key.id,
            "windowAction": windowAction,
        ]
        if let payload {
            userInfo["payload"] = payload as any Sendable
        }
        NotificationCenter.default.post(name: .didRequestWindowAction, object: nil, userInfo: userInfo)
    }
}
