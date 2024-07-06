//
//  Skin+Injection.swift
//
//
//  Created by Kristian Mitra on 4/29/24.
//

import Factory
import HighwindLibrary
import HWDViewModelProtocols
import HWDViewModels

extension Container {
    // MARK: ViewModels
    
    public var createBookingPageViewModel: Factory<CreateBookingPageViewModelProtocol> {
        self { CreateBookingPageViewModel(digitalApiResourcesController: self.digitalApiResourcesController(),
                                    searchController: self.searchController()) }
    }
    
    public var flightSelectPageViewModel: Factory<FlightSelectPageViewModelProtocol> {
        self { FlightSelectPageViewModel(searchController: self.searchController()) }
    }
}
