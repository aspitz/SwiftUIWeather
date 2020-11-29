//
//  ForecastEntity.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation

public struct ForecastEntity {
    public struct Location {
        let city: String
        let state: String
    }
    
    public struct PeriodForecast {
        let title: String
        let forecast: String
        let temperature: Int
    }
    
    let location: Location
    let forecasts: [PeriodForecast]
    let updated: Date
}
