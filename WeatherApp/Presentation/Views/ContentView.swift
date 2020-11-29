//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/11/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var businessLogic: WeatherBusinessLogic

    var body: some View {
        NavigationView {
            VStack {
                if businessLogic.forecasts.isEmpty {
                    ProgressView()
                } else {
                    ForecastsView()
                }
            }
            .navigationBarTitle(businessLogic.location)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        businessLogic.reload()
                                    }) {
                                        Image(systemName: "arrow.clockwise.circle").imageScale(.large)
                                    }
            )
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environmentObject(NOAAWeather.Service.mock)
//    }
//}
