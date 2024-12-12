/*
 Notification+Extension.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

extension Notification: @retroactive @unchecked Sendable {}

extension Notification.Name {
    static let didRequestWindowAction = Notification.Name("didRequestWindowAction")
}
