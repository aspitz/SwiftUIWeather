//
//  Forecast.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/11/20.
//

import Foundation

public extension Weather {
    struct Forecast: Decodable {
        public struct Properties: Decodable {
            public struct Period: Decodable, Identifiable {
                public var id: Int { return number }
                
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
            
            public let periods: [Period]
        }
        
        public let properties: Properties
    }
}

struct Mock {
    private static let periodJSON = """
    {
        "number": 1,
        "name": "Today",
        "startTime": "2020-09-12T07:00:00-04:00",
        "endTime": "2020-09-12T18:00:00-04:00",
        "isDaytime": true,
        "temperature": 67,
        "temperatureUnit": "F",
        "temperatureTrend": null,
        "windSpeed": "5 to 9 mph",
        "windDirection": "E",
        "icon": "https://api.weather.gov/icons/land/day/fog/few?size=medium",
        "shortForecast": "Patchy Fog then Sunny",
        "detailedForecast": "Patchy fog before 9am. Sunny, with a high near 67. East wind 5 to 9 mph."
    }
    """
    
    static let period = try! JSONDecoder().decode(Weather.Forecast.Properties.Period.self, from: periodJSON.data(using: .utf8)!)
    static let forecast = ForecastViewModel(model: period)
}
