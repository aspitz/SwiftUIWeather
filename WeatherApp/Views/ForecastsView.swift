//
//  ForecastsView.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/13/20.
//

import SwiftUI

struct ForecastsView: View {
    public let viewModel: ForecastsViewModel
    
    var body: some View {
        List(viewModel.forecasts) { forecast in
            ForecastView(viewModel: forecast)
        }
        .navigationBarTitle(viewModel.location)
        .navigationBarItems(trailing:
            Button(action: {
                viewModel.reload()
            }) {
                Image(systemName: "arrow.clockwise.circle").imageScale(.large)
            }
        )
    }
}

//struct ForecastsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastsView()
//    }
//}
