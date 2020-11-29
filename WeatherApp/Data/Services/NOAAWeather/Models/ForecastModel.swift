//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation

extension NOAAWeather {
    public struct ForecastModel: Decodable {
        public struct Properties: Decodable {
            public struct Period: Decodable {
                public let number: Int
                public let name: String
                public let startTime: String
                public let endTime: String
                public let isDaytime: Bool
                public let temperature: Int
                public let temperatureUnit: String
                public let temperatureTrend: String?
                public let windSpeed: String
                public let windDirection: String
                public let icon: String
                public let shortForecast: String
                public let detailedForecast: String
            }
            
            public let updated: Date
            public let periods: [Period]
        }
        
        public let properties: Properties
    }
}
