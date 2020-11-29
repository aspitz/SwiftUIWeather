//
//  Future.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/29/20.
//

import Foundation
import Combine

public extension Future {
    func removeCompletion() ->  AnyPublisher<Output, Failure> {
        return Publishers.Concatenate(prefix: self, suffix: Empty(completeImmediately: false))
            .eraseToAnyPublisher()
    }
}
