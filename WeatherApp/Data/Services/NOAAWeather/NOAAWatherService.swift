//
//  NOAAWatherService.swift
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
    class Service: WeatherService {
        private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
        
        func getForecast(for location: CLLocationCoordinate2D) -> AnyPublisher<NOAAWeather.ForecastModel, Error> {
            return getPoint(for: location)
                .flatMap(getForecast(pointForecast:))
                .eraseToAnyPublisher()
        }
        
        func getPoint(for location: CLLocationCoordinate2D) -> AnyPublisher<String, Error> {
            let locationString = "\(location.latitude),\(location.longitude)"
            let weatherPointForecast = "https://api.weather.gov/points/\(locationString)"
            let weatherPointForecastURL = URL(string: weatherPointForecast)!
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            return URLSession.shared.dataTaskPublisher(for: weatherPointForecastURL)
                .map { $0.data }
                .decode(type: NOAAWeather.PointModel.self, decoder: decoder)
                .map { $0.properties.forecast }
                .eraseToAnyPublisher()
        }
        
        func getForecast(pointForecast: String) -> AnyPublisher<NOAAWeather.ForecastModel, Error> {
            let pointForecastURL = URL(string: pointForecast)!
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            return URLSession.shared.dataTaskPublisher(for: pointForecastURL)
                .map { $0.data }
                .decode(type: NOAAWeather.ForecastModel.self, decoder: decoder)
                .eraseToAnyPublisher()
        }
    }
}

extension CLLocationCoordinate2D: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}
