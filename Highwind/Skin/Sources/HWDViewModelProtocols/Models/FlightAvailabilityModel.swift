//
//  FlightAvailabilityModel.swift
//
//
//  Created by Kristian Mitra on 3/5/24.
//

import DigitalAPIClient
import Foundation

public struct FlightAvailabilityModel : Hashable {
    
    // MARK: - Fields
    public let journeyKey: String
    public let flightNumber: String
    public let fare: Double
    public let fareKey: String
    public var departureDate: String
    public var arrivalDate: String
    public let departureTime: String
    public let arrivalTime: String
    public let flightDuration: String
    public let originStation: String
    public let destinationStation: String
    
    // MARK: - Constructors
    
    public init(journey: Components.Schemas.AvailableJourney, fareReference: Components.Schemas.FareReference) {
        self.journeyKey = journey.journeyKey ?? ""
        
        let segment = journey.segments?.first
        let carrierCode = segment?.identifier?.carrierCode ?? ""
        let identifier = segment?.identifier?.identifier ?? ""
        self.flightNumber = "\(carrierCode) \(identifier)"
        
        let availableFares = journey.fares?.first
        self.fareKey = availableFares?.fareAvailabilityKey ?? ""
        
        // there should be a more complicated calculation of the displayed fare,
        // but we will make it simple for now.
        self.fare = fareReference.totals?.fareTotal ?? 0
        
        let isoDateFormatter = ISO8601DateFormatter()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .medium
        
        let departureDateString = journey.designator?.departure ?? ""
        let arrivalDateString = journey.designator?.arrival ?? ""
        let departureDate = isoDateFormatter.date(from: "\(departureDateString)Z") ?? Date.distantPast
        let arrivalDate = isoDateFormatter.date(from: "\(arrivalDateString)Z") ?? Date.distantPast
        let gregorianCalendar = Calendar(identifier: .gregorian)
        let dateComponents = gregorianCalendar.dateComponents([.hour, .minute], from: departureDate, to: arrivalDate)
        
        self.departureDate = dateFormatter.string(from: departureDate)
        self.arrivalDate = dateFormatter.string(from: arrivalDate)
        self.departureTime = timeFormatter.string(from: departureDate)
        self.arrivalTime = timeFormatter.string(from: arrivalDate)
        self.flightDuration = "\(dateComponents.hour ?? 00):\(dateComponents.minute ?? 00)"
        
        self.originStation = journey.designator?.origin ?? ""
        self.destinationStation = journey.designator?.destination ?? ""
    }
}
