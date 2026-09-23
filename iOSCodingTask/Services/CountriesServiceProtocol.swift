//
//  Untitled.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-23.
//

import Foundation

protocol CountriesServiceProtocol {
    func fetchCountries() async throws -> [Country]
}
