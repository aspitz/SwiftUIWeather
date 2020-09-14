//
//  UpdateView.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/13/20.
//

import SwiftUI

struct UpdateView: View {
    public let viewModel: String

    var body: some View {
        Text(viewModel)
            .font(.footnote)
            .fontWeight(.ultraLight)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView(viewModel: "September 13, 2020 at 12:23 PM")
    }
}
