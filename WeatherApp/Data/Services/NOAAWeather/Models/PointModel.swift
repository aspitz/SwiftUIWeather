//
//  PointModel.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation

extension NOAAWeather {
    public struct PointModel: Decodable {
        public struct Properties: Decodable {
            public let forecast: String
            public let forecastHourly: String
        }
        
        public let properties: Properties
    }
}
