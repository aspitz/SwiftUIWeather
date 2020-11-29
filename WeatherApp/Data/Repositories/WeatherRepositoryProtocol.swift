//
//  WeatherRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation
import Combine

protocol WeatherRepositoryProtocol {
    var forecast: AnyPublisher<ForecastEntity, Error> { get }

    func forecast(for location: String)
}

