/*
 WindowSceneMessenger.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

public struct WindowSceneMessenger {
    public static func request(
        windowAction: WindowAction,
        windowKey: String,
        supplements: [String: any Sendable] = [:]
    ) {
        let userInfo: [AnyHashable: Any] = [
            "windowKey": windowKey,
            "windowAction": windowAction,
            "supplements": Supplements(value: supplements),
        ]
        NotificationCenter.default.post(name: .didRequestWindowAction, object: nil, userInfo: userInfo)
    }
}
