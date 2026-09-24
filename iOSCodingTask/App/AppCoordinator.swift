//
//  AppCoordinator.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-22.
//

import UIKit

final class AppCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        
        let service = CountriesService(
            apiKey: AppConfiguration.restCountriesAPIKey
        )
        let viewModel = CountrySelectionViewModel(service:service)
        let viewController = CountrySelectionViewController(viewModel: viewModel)
        
        viewController.onCountrySelected = { [weak self] country in
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

