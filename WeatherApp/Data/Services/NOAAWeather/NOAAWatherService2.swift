//
//  NOAAWatherService2.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation
import CoreLocation
import Combine

// https://api.weather.gov/points/42.3601,-71.0589
// https://api.weather.gov/gridpoints/BOX/70,76/forecast/hourly

public struct NOAAWeather {
    struct Service: WeatherService {
        private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()

        func getForecast(for location: CLLocationCoordinate2D) -> AnyPublisher<NOAAWeather.ForecastModel, Error> {
            let locationString = "\(location.latitude),\(location.longitude)"
            let weatherPointForecast = "https://api.weather.gov/points/\(locationString)"
            let weatherPointForecastURL = URL(string: weatherPointForecast)!
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            return URLSession.shared.dataTaskPublisher(for: weatherPointForecastURL)
                .map { $0.data }
                .decode(type: NOAAWeather.PointModel.self, decoder: decoder)
                .map { $0.properties }
                .replaceError(with: nil)
                .compactMap{ $0 }
                .map { $0.forecast }
                .map { URL(string: $0)! }.print()
                .flatMap { URLSession.shared.dataTaskPublisher(for: $0) }
                .map { $0.data }
                .decode(type: NOAAWeather.ForecastModel.self, decoder: decoder)
                .eraseToAnyPublisher()
        }
    }
}
