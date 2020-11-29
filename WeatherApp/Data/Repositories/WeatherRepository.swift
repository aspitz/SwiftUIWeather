//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation
import CoreLocation
import Combine

class WeatherRepository: WeatherRepositoryProtocol {
    var forecast: AnyPublisher<ForecastEntity, Error>

    private var geocorderService: GeocoderService
    private var weatherService: WeatherService
    
    private var locationSubject: PassthroughSubject<CLLocationCoordinate2D, Never>
    private var locationCancellable: AnyCancellable
    
    init(locationService: LocationService = AppleLocation.Service.default,
         geocorderService: GeocoderService = AppleGeocoder.Service.default,
         weatherService: WeatherService = NOAAWeather.Service()) {

        self.geocorderService = geocorderService
        self.weatherService = weatherService
        
        locationSubject = PassthroughSubject()
        
        let forecastLocation = locationSubject
            .share()
        
        let location = forecastLocation
            .flatMap( geocorderService.getPlacemark(location:) )
            .map( ForecastEntity.Location.init(location:) )
            .eraseToAnyPublisher()

        let forecasts = forecastLocation
            .flatMap( weatherService.getForecast(for:) )
            .eraseToAnyPublisher()

        forecast = location
            .zip(forecasts)
            .map {
                let periodForecasts = NOAAWeather.ForecastModel.toForecastEntities(forecastModel: $0.1)
                let update = $0.1.properties.updated
                return ForecastEntity(location: $0.0, forecasts: periodForecasts, updated: update)
            }
            .eraseToAnyPublisher()
        
        locationCancellable = locationService.getLocation()
            .subscribe(locationSubject)
    }
    
    func forecast(for location: String) {
        locationCancellable.cancel()
        
        locationCancellable = geocorderService.getPlacemark(location: location)
            .compactMap { $0.location }
            .map { $0.coordinate }
            .catch { _ in Empty<CLLocationCoordinate2D, Never>() }
            .eraseToAnyPublisher()
            .subscribe(locationSubject)
    }
}

private extension ForecastEntity.Location {
    init(location: CLPlacemark) {
        self.init(city: location.locality!, state: location.administrativeArea!)
    }
}

private extension ForecastEntity.PeriodForecast {
    init(period: NOAAWeather.ForecastModel.Properties.Period) {
        self.init(title: period.name, forecast: period.detailedForecast, temperature: period.temperature)
    }
}

private extension NOAAWeather.ForecastModel {
    static func toForecastEntities(forecastModel: NOAAWeather.ForecastModel) -> [ForecastEntity.PeriodForecast] {
        forecastModel.properties.periods.map(ForecastEntity.PeriodForecast.init(period:))
    }
}
