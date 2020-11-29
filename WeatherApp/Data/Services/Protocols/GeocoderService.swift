//
//  GeocoderService.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation
import CoreLocation
import Combine

public protocol GeocoderService {
    func getPlacemark(location: CLLocationCoordinate2D) -> AnyPublisher<CLPlacemark, Error>
    func getPlacemark(location: String) -> AnyPublisher<CLPlacemark, Error>
}
