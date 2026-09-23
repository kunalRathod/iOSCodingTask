//
//  CountrySelectionViewModel.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-23.
//

import Foundation
import UIKit

final class CountrySelectionViewModel{
    
    private let service: CountriesServiceProtocol
    
    private(set) var countries: [Country] = []
    private(set) var selectedOriginCountry: Country?
    private(set) var selectedDestinationCountry: Country?
    
    init(service: CountriesServiceProtocol) {
        self.service = service
    }
    
    func loadCountries() async throws {
        countries = try await service.fetchCountries()
            .sorted {
                $0.names.common < $1.names.common
            }
    }
    
    func selectOrigin(_ country: Country) {
        selectedOriginCountry = country
        
        if selectedDestinationCountry == country {
            selectedDestinationCountry = nil
        }
    }
    
    func selectDestination(_ country: Country) {
        selectedDestinationCountry = country
    }
    
    var availableDestinationCountries: [Country] {
        countries.filter {
            $0 != selectedOriginCountry
        }
    }
}

