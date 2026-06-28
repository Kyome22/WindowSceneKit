/*
 Publisher+Extension.swift
 WindowSceneKit

 Created by Takuto Nakamura on 2026/06/28.
 
*/

import Combine

extension Publisher where Self.Failure == Never {
    func bufferedValues() -> AsyncPublisher<Publishers.Buffer<Self>> {
        self.buffer(size: 5, prefetch: .keepFull, whenFull: .dropOldest)
            .values
    }
}
