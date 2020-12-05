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
        
        private let currentLocationSubject: PassthroughSubject<CLLocationCoordinate2D, Error>
        private let locationManager = CLLocationManager()
        
        override private init() {
            currentLocationSubject = PassthroughSubject<CLLocationCoordinate2D, Error>()
            
            super.init()
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        func getLocation() -> AnyPublisher<CLLocationCoordinate2D, Error> {
            locationManager.requestLocation()
            
            return currentLocationSubject
                .compactMap{ $0 }
                .removeDuplicates()
                .eraseToAnyPublisher()
        }
    }
}

extension AppleLocation.Service: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocationSubject.send(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentLocationSubject.send(completion: .failure(error))
    }
}
