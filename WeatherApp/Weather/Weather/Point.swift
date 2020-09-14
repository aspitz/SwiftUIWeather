//
//  Point.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/11/20.
//

import Foundation

public extension Weather {
    struct Point: Decodable {
        public struct Properties: Decodable {
            public struct RelativeLocation: Decodable {
                public struct Properties: Decodable {
                    public let city: String
                    public let state: String
                }
                
                public let properties: Properties
            }
            
            public let forecast: String
            public let forecastHourly: String
            public let relativeLocation: RelativeLocation
        }
        
        public let properties: Properties
    }
}
