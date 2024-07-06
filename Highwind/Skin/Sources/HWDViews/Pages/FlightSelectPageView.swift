//
//  FlightSelectPageView.swift
//  Highwind
//
//  Created by Kristian Mitra on 2/25/24.
//

import SwiftUI
import HWDViewModelProtocols
import Factory

public struct FlightSelectPageView: View {
    
    // MARK: - Fields
    
    @EnvironmentObject private var pageParams: FlightSelectPageParameters
    @State private var viewModel: FlightSelectPageViewModelProtocol = Container.shared.flightSelectPageViewModel()

    // MARK: - View
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.availableFlights, id: \.self) { availableFlight in
                        VStack(alignment: .leading) {
                            Text("Flight: \(availableFlight.flightNumber)")
                            Text("Fare: \(availableFlight.fare)")
                            Text("Departure: \(availableFlight.departureDate) \(availableFlight.departureTime)")
                            Text("Arrival: \(availableFlight.arrivalDate) \(availableFlight.arrivalTime)")
                            Text("Duration: \(availableFlight.flightDuration)")
                        }
                        .padding([.bottom], 20)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Available Flights")
        }
        .onFirstAppear {
            Task {
                await viewModel.initializeAsync(pageParams: pageParams)
            }
        }
    }
}

#Preview {
    FlightSelectPageView()
        .environmentObject(FlightSelectPageParameters())
}
