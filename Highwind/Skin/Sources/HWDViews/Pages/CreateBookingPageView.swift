//
//  CreateBookingPageView.swift
//  Highwind
//
//  Created by Kristian Mitra on 12/27/23.
//

import SwiftUI
import HighwindSkin
import HWDViewModelProtocols
import HWDViewModels
import DigitalAPIClient
import Factory

public struct CreateBookingPageView: View {
    
    // MARK: - Fields
    
    @Environment(\.calendar) var calendar
    @State private var viewModel: CreateBookingPageViewModelProtocol = Container.shared.createBookingPageViewModel()
    
    // uncomment for multi-date picker
    private var dateBounds: Range<Date> {
        let start = Date.now
        let end = calendar.date(byAdding: DateComponents(year: 1), to: Date.now)!
        
        return start..<end
    }
    
    private var dateBoundsClosedRange: ClosedRange<Date> {
        let start = Date.now
        let end = calendar.date(byAdding: DateComponents(year: 1), to: Date.now)!
        
        return start...end
    }
    
    // MARK: - States
    
    @State private var selectedJourneyType: String = "One Way"
    @State private var isDestinationDisabled: Bool = true
    @State private var showFlightSelectPage: Bool = false
    
//    @State private var dates: Set<DateComponents> = []
 
    public init() {
        
    }
    
    // MARK: - View
    
    public var body: some View {
        NavigationStack {
            Form {
                Section("I'm going...") {
                    // Origin
                    Picker(selection: $viewModel.selectedOrigin, content: {
                        ForEach(viewModel.originStations, id: \.self, content: { station in
                            Text(station.stationCode)
                                .fontWeight(.bold)
                                .tag(station.stationCode)
                        })
                    },
                    label: {
                        Label("Origin", systemImage: "airplane.departure")
                    })
                    .onChange(of: viewModel.selectedOrigin, { oldValue, newValue in
                        if newValue != "" {
                            if oldValue != "" {
                                viewModel.updateDestinationStations()
                            }
                            isDestinationDisabled = false
                        }
                    })
                    .pickerStyle(.navigationLink)
                    
                    // Destination
                    Picker(selection: $viewModel.selectedDestination, content: {
                        ForEach(viewModel.destinationStations, id: \.self, content: { station in
                            Text(station.stationCode)
                                .fontWeight(.bold)
                                .tag(station.stationCode)
                        })
                    },
                    label: {
                        Label("Destination", systemImage: "airplane.arrival")
                    })
                    .pickerStyle(.navigationLink)
                    .disabled(isDestinationDisabled)
                }
                
                Section("I'll travel by..") {
                    DatePicker("Dates Available",
                               selection: $viewModel.selectedDate,
                               in: dateBoundsClosedRange,
                               displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                }

                Section("I'm flying with...") {
                    Stepper(value: $viewModel.adultCount, in:1...9, step: 1) {
                        Text("Guest(s): \(viewModel.adultCount)")
                    }
                    
                    Text("Child")
                        .disabled(true)
                    
                    Text("Infant")
                        .disabled(true)
                }
                
                Button("Search for flights") {
                    showFlightSelectPage = true
                }
                .frame(maxWidth:.infinity, alignment: .center)
            }
            .navigationTitle("Booking Hub")
            .navigationDestination(isPresented: $showFlightSelectPage) {
                
                let pageParameters = FlightSelectPageParameters(
                    selectedOrigin: viewModel.selectedOrigin,
                    selectedDestination: viewModel.selectedDestination,
                    selectedDate: viewModel.selectedDate,
                    adultCount: viewModel.adultCount)
                
                FlightSelectPageView()
                    .environmentObject(pageParameters)
            }
        }
        .onFirstAppear {
            Task {
                await viewModel.initializeAsync()
            }
        }
    }
}

#Preview {
    CreateBookingPageView()
}
