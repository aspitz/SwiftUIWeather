//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/11/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weather = Weather.Service()
    
    var body: some View {
        NavigationView {
            VStack {
                if weather.forects.isEmpty {
                    ProgressView()
                } else {
                    List {
                        ForEach(weather.forects) { forecast in
                            ForecastView(viewModel: ForecastViewModel(model: forecast))
                        }
                        UpdateView(viewModel: weather.updateDate)
                    }
                }
            }
            .navigationBarTitle(weather.location)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        weather.reload()
                                    }) {
                                        Image(systemName: "arrow.clockwise.circle").imageScale(.large)
                                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weather: Weather.Service.mock)
    }
}
