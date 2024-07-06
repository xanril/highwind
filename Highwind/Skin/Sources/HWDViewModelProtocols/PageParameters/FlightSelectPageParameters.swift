//
//  FlightSelectPageParameters.swift
//
//
//  Created by Kristian Mitra on 2/25/24.
//

import Foundation

public class FlightSelectPageParameters : ObservableObject {
    
    public var selectedOrigin: String = ""
    public var selectedDestination: String = ""
    public var selectedDate: Date = Date.now
    public var adultCount: Int32 = 1
    
    public init() {
        
    }
    
    public init(selectedOrigin: String, selectedDestination: String, selectedDate: Date, adultCount: Int32) {
        self.selectedOrigin = selectedOrigin
        self.selectedDestination = selectedDestination
        self.selectedDate = selectedDate
        self.adultCount = adultCount
    }
}
