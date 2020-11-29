//
//  ForecastsView.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/13/20.
//

import SwiftUI

struct ForecastsView: View {
    @EnvironmentObject var businessLogic: WeatherBusinessLogic
    @State private var location : String = ""

    var body: some View {
        List {
            TextField("Location", text: $location, onCommit: { businessLogic.forecast(for: location) })
            ForEach(businessLogic.forecasts) { forecast in
                ForecastView(viewModel: forecast)
            }
            UpdateView(date: businessLogic.updateDate)
        }
        .listStyle(PlainListStyle())
    }
}

//struct ForecastsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastsView().environmentObject(NOAAWeather.Service.mock)
//    }
//}
