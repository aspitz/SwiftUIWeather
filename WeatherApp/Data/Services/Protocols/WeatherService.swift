//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation
import CoreLocation
import Combine

public protocol WeatherService {
    func getForecast(for location: CLLocationCoordinate2D) -> AnyPublisher<NOAAWeather.ForecastModel, Error>
}
