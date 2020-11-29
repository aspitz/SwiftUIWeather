//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/11/20.
//

import SwiftUI

@main
struct WeatherApp: App {
    private let businessLogic = WeatherBusinessLogic(weatherRepository: WeatherRepository())
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(businessLogic)
        }
    }
}
