/*
 WindowAction.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2024/12/10.
 
*/

import SwiftUI

public enum WindowAction {
    case open
    case close

    var isOpen: Bool {
        self == .open
    }
}
