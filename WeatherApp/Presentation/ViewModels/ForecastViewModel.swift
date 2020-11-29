//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/12/20.
//

import Foundation

public struct ForecastViewModel: Identifiable {
    public let id: Int
    
    public let title: String
    public let forecast: String
    public let temperature: Int
    
    static var count: Int = 0
    
    public init(model: ForecastEntity.PeriodForecast) {
        self.id = ForecastViewModel.count
        ForecastViewModel.count += 1
        
        self.title = model.title
        self.forecast = model.forecast
        self.temperature = model.temperature
    }
}
