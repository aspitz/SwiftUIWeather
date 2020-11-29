//
//  ForecastsViewModel.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/12/20.
//

import Foundation

public struct ForecastsViewModel {
    public let location: String
    public let forecasts: [ForecastViewModel]
    
    public func reload() {}
}
