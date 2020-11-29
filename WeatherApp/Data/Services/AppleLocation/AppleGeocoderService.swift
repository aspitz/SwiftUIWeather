//
//  GeocoderService.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 11/28/20.
//

import Foundation
import CoreLocation
import Combine

public struct AppleGeocoder {
    class Service: GeocoderService {
        static public var `default` = Service()
        private let geocoder: CLGeocoder
        
        private init() {
            geocoder = CLGeocoder()
        }
        
        func getPlacemark(location: CLLocationCoordinate2D) -> AnyPublisher<CLPlacemark, Error> {
            let clLocation = location.location()
            return Future { promise in
                self.geocoder.reverseGeocodeLocation(clLocation) {
                    if $1 == nil, let placemarks = $0, let placemark = placemarks.first {
                        promise(Result.success(placemark))
                    }
                }
            }
            .removeCompletion()
        }

        func getPlacemark(location: String) -> AnyPublisher<CLPlacemark, Error> {
            return Future { promise in
                self.geocoder.geocodeAddressString(location) {
                    if let error = $1 {
                        promise(.failure(error))
                    } else if let placemark = $0?.first {
                        promise(.success(placemark))
                    }
                }
            }
            .removeCompletion()
        }
    }
}
