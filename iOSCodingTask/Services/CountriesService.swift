//
//  CountriesService.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-23.
//

import Foundation

final class CountriesService: CountriesServiceProtocol {
    
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchCountries() async throws -> [Country] {
        var allCountries: [Country] = []
        var offset = 0
        let limit = 100
        var hasMore = true
        
        while hasMore {
            
            let urlString =
            "https://api.restcountries.com/countries/v5" +
            "?limit=\(limit)" +
            "&offset=\(offset)" +
            "&response_fields=names.common,names.official,capitals.name,flag.emoji,flag.url_png,region,population,currencies,languages"
            
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: url)
            
            request.setValue(
                "Bearer \(apiKey)",
                forHTTPHeaderField: "Authorization"
            )
            
            let (data, urlResponse) = try await URLSession.shared.data(
                for: request
            )
            
            guard let httpResponse = urlResponse as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                throw URLError(.badServerResponse)
            }
            
            print("Status code:", httpResponse.statusCode)
            
            let decodedResponse = try JSONDecoder().decode(
                CountriesResponse.self,
                from: data
            )
            
            allCountries.append(
                contentsOf: decodedResponse.data.objects
            )
            
            hasMore = decodedResponse.data.meta.more
            
            offset =
            decodedResponse.data.meta.offset +
            decodedResponse.data.meta.count
        }
        
        return allCountries
    }
}
