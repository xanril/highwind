//
//  HighwindApp.swift
//  Highwind
//
//  Created by Kristian Mitra on 12/27/23.
//

import SwiftUI
import HWDViewModelProtocols
import HWDViews

@main
struct HighwindApp: App {
    
    let pageParameters = FlightSelectPageParameters(
        selectedOrigin: "ATL",
        selectedDestination: "LAX",
        selectedDate: Date.now,
        adultCount: 1)
    
    var body: some Scene {
        WindowGroup {
            CreateBookingPageView()
//            FlightSelectPageView()
//                .environmentObject(pageParameters)
        }
    }
}
