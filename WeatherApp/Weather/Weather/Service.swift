//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/11/20.
//

import Foundation
import Combine

// https://api.weather.gov/points/{latitude},{longitude}
// https://api.weather.gov/points/42.4473,-71.2272
// https://api.weather.gov/gridpoints/BOX/64,79/forecast

public struct Weather {
    class Service: ObservableObject {
        private let locationService: LocationService = LocationService()
        
        @Published var location: String = ""
        @Published var forects = [Weather.Forecast.Properties.Period]()
        @Published var update: Void = ()
        @Published var updateDate: String = ""

        private let dateFormatter = DateFormatter()
        private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()

        public init(mock: Bool = false) {
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale.current

            if !mock {
                let weatherPoint = locationService.$userLocation.print()
                    .compactMap{ $0 }
                    .map { "\($0.latitude),\($0.longitude)" }
                    .distinct()
                    .combineLatest($update)
                    .map { $0.0 }
                    .map { "https://api.weather.gov/points/\($0)"}
                    .map { URL(string: $0)! }
                    .flatMap { URLSession.shared.dataTaskPublisher(for: $0) }
                    .map { $0.data }
                    .decode(type: Weather.Point.self, decoder: JSONDecoder())
                    .map { $0.properties }
                    .replaceError(with: nil)
                    .compactMap{ $0 }
                    .share()
                
                weatherPoint
                    .map { $0.relativeLocation.properties }
                    .map { "\($0.city), \($0.state)" }
                    .replaceError(with: "")
                    .receive(on: DispatchQueue.main)
                    .assign(to: \.location, on: self)
                    .store(in: &cancellable)
                
                weatherPoint
                    .map { $0.forecast }
                    .map { URL(string: $0)! }
                    .flatMap { URLSession.shared.dataTaskPublisher(for: $0) }
                    .map { $0.data }
                    .decode(type: Weather.Forecast.self, decoder: JSONDecoder())
                    .map { $0.properties.periods }
                    .replaceError(with: [])
                    .receive(on: DispatchQueue.main)
                    .assign(to: \.forects, on: self)
                    .store(in: &cancellable)
                
                weatherPoint
                    .map { _ in self.dateFormatter.string(from: Date())}
                    .replaceError(with: "")
                    .receive(on: DispatchQueue.main)
                    .assign(to: \.updateDate, on: self)
                    .store(in: &cancellable)

            }
        }
                
        public func reload() {
            update = ()
        }
    }
}

extension Weather.Service {
    public static var mock: Weather.Service {
        let srvc = Weather.Service(mock: true)
        srvc.location = "Lexington, MA"
        srvc.forects = [Mock.period, Mock.period]
        return srvc
    }
}

extension Publisher where Self.Output : Equatable {
    public func distinct() -> AnyPublisher<Self.Output, Self.Failure> {
        self
            .scan(([], nil)) { $0.0.contains($1) ? ($0.0, nil) : ($0.0 + [$1], $1) }
            .compactMap { $0.1 }
            .eraseToAnyPublisher()
    }
}
