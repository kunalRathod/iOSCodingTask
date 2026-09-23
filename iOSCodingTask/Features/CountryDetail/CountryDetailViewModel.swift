//
//  CountryDetailViewModel.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-23.
//

import Foundation

final class CountryDetailViewModel {

    let country: Country

    init(country: Country) {
        self.country = country
    }

    var countryName: String {
        country.names.common
    }

    var officialName: String {
        country.names.official
    }

    var capital: String {
        country.capitals.first?.name ?? "N/A"
    }

    var region: String {
        country.region
    }

    var population: String {
        country.population.formatted()
    }

    var currencies: String {
        country.currencies
            .map { "\($0.name) (\($0.code))" }
            .joined(separator: ", ")
    }

    var languages: String {
        country.languages
            .map(\.name)
            .joined(separator: ", ")
    }

    var flagURL: URL? {
        URL(string: country.flag.urlPng)
    }
}

