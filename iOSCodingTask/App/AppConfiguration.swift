//
//  AppConfiguration.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-24.
//

import Foundation

enum AppConfiguration {

    static var restCountriesAPIKey: String {
        guard let apiKey = Bundle.main.object(
            forInfoDictionaryKey: "REST_COUNTRIES_API_KEY"
        ) as? String,
              !apiKey.isEmpty else {
            fatalError("REST Countries API key is missing")
        }

        return apiKey
    }
}
