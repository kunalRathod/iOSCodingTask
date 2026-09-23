//
//  AppCoordinator.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-22.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        
        guard let apiKey = Bundle.main.object(
            forInfoDictionaryKey: "REST_COUNTRIES_API_KEY"
        ) as? String,
              !apiKey.isEmpty else {
            fatalError("REST Countries API key is missing")
        }
        
        
        let service = CountriesService(apiKey: apiKey)
        let viewModel = CountrySelectionViewModel(service:service)
        let viewController = CountrySelectionViewController(viewModel: viewModel)
        
        viewController.onDestinationSelected = { [weak self] country in
            self?.showCountryDetail(country)
        }
        
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func showCountryDetail(_ country: Country) {
        let viewModel = CountryDetailViewModel(
            country: country
        )

        let viewController = CountryDetailViewController(
            viewModel: viewModel
        )

        navigationController.pushViewController(
            viewController,
            animated: true
        )
    }
}

