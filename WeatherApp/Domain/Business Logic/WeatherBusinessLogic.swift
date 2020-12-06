//
//  WeatherBusinessLogic.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation
import Combine

class WeatherBusinessLogic: ObservableObject {
    @Published var location: String
    @Published var forecasts: [ForecastViewModel]
    @Published var updateDate: Date?
    
    private let weatherRepository: WeatherRepositoryProtocol
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()

    init(weatherRepository: WeatherRepositoryProtocol) {
        location = ""
        forecasts = []
        updateDate = nil
        
        self.weatherRepository = weatherRepository
        
        let sharedForecast = weatherRepository.forecast.share()
        
        sharedForecast
            .map { $0.location }
            .map { "\($0.city), \($0.state)" }
            .receive(on: DispatchQueue.main)
            .replaceError(with: "")
            .assign(to: \.location, on: self)
            .store(in: &cancellable)
        
        sharedForecast
            .map { $0.forecasts }
            .map { $0.map(ForecastViewModel.init(model:)) }
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: \.forecasts, on: self)
            .store(in: &cancellable)
        
        sharedForecast
            .map { $0.updated }
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .assign(to: \.updateDate, on: self)
            .store(in: &cancellable)
    }
    
    func reload() { forecast(for: location) }
    
    func forecast(for location: String) {
        if self.location != location {
            self.location = ""
        }
        forecasts = []
        
        weatherRepository.forecast(for: location)
    }
    
    func forecastForCurentLocation() {
        weatherRepository.forecastForCurentLocation()
    }
}
