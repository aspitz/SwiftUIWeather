//
//  Service.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/13/20.
//

import Foundation
import Combine
import CoreLocation

public struct AppleLocation {
    class Service: NSObject, LocationService {
        static public var `default` = Service()
        
        @Published private var currentLocation: CLLocationCoordinate2D?

        private let locationManager = CLLocationManager()
        
        override private init() {
            super.init()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        func getLocation() -> AnyPublisher<CLLocationCoordinate2D, Never> {
            return $currentLocation
                .compactMap{ $0 }
                .removeDuplicates()
                .eraseToAnyPublisher()
        }
    }
}

extension AppleLocation.Service: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
    }
}
