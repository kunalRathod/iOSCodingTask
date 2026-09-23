//
//  Country.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-23.
//

import Foundation

struct CountriesResponse: Decodable {
    let data: CountriesData
}

struct CountriesData: Decodable {
    let objects: [Country]
    let meta: CountriesMeta
}

struct CountriesMeta: Decodable {
    let total: Int
    let count: Int
    let limit: Int
    let offset: Int
    let more: Bool
}

struct Country: Decodable, Equatable {
    let names: CountryNames
    let capitals: [Capital]
    let flag: CountryFlag
    let region: String
    let population: Int
    let currencies: [Currency]
    let languages: [Language]
}

struct CountryNames: Decodable, Equatable {
    let common: String
    let official: String
}

struct Capital: Decodable, Equatable {
    let name: String
}

struct CountryFlag: Decodable, Equatable {
    let emoji: String
    let urlPng: String
    
    enum CodingKeys: String, CodingKey {
        case emoji
        case urlPng = "url_png"
    }
}

struct Currency: Decodable, Equatable {
    let code: String
    let name: String
    let symbol: String
}

struct Language: Decodable, Equatable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
