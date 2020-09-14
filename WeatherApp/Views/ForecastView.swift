//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/12/20.
//

import SwiftUI

struct ForecastView: View {
    public let viewModel: ForecastViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                Text(viewModel.forecast)
                    .font(.footnote)
            }
            Spacer()
            Text("\(viewModel.temperature)°")
                .font(.title)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: Mock.forecast)
    }
}
