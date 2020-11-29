//
//  CLLocationCoordinate2D.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func location() -> CLLocation { CLLocation(latitude: latitude, longitude: longitude) }
}

extension CLLocationCoordinate2D: Equatable {
    static public func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
