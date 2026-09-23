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
        
        let viewModel = CountrySelectionViewModel()
        let viewController = CountrySelectionViewController(viewModel: viewModel)
        viewController.view.backgroundColor = .systemBackground
        viewController.title = "Vacation Destination"
        
        navigationController.setViewControllers([viewController], animated: false)
    }
}

