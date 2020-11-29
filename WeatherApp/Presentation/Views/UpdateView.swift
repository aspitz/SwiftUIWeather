//
//  UpdateView.swift
//  WeatherApp
//
//  Created by Ayal Spitz on 9/13/20.
//

import SwiftUI

struct UpdateView: View {
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    private let viewModel: String

    init(date: Date?) {
        guard let date = date else {
            viewModel = ""
            return
        }
        
        viewModel = UpdateView.formatter.string(from: date)
    }
    
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
        UpdateView(date: Date())
    }
}
