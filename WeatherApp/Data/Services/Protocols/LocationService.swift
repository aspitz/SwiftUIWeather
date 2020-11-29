//
//  LocationService.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation
import CoreLocation
import Combine

public protocol LocationService {
    func getLocation() -> AnyPublisher<CLLocationCoordinate2D, Never>
}
