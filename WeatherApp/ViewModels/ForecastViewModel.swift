//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/12/20.
//

import Foundation

public struct ForecastViewModel: Identifiable {
    public let id: Int
    
    public let name: String
    public let forecast: String
    public let temperature: Int
    
    public init(model: Weather.Forecast.Properties.Period) {
        self.id = model.number
        
        self.name = model.name
        self.forecast = model.detailedForecast
        self.temperature = model.temperature
    }
}
