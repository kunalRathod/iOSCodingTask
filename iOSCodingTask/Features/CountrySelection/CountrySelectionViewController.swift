//
//  CountrySelectionViewController.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-23.
//

import Foundation
import UIKit

final class CountrySelectionViewController: UIViewController{
    
    private let viewModel: CountrySelectionViewModel
    
    private let countryOriginLabel: UILabel = {
        let label = UILabel()
        label.text = "Origin Country"
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let countryDestinationLabel: UILabel = {
        let label = UILabel()
        label.text = "Destination Country"
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var originButton: UIButton = makeCountryButton( title: "Select Country")
    
    private lazy var destinationButton: UIButton = makeCountryButton( title: "Select Country")
    
    var onDestinationSelected: ((Country) -> Void)?
    
    init(viewModel: CountrySelectionViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Country"
        view.backgroundColor = .systemBackground
        
        configureLayout()
        loadCountries()
    }
    
    private func loadCountries() {
        Task {
            do {
                try await viewModel.loadCountries()

                print("Loaded \(viewModel.countries.count) countries")

                configureMenus()

                originButton.isEnabled = true
                destinationButton.isEnabled = false
            } catch {
                print("Failed to load countries:", error)
                showError(error)
            }
        }
    }
    
    private func makeCountryButton(title: String) -> UIButton {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = title
        configuration.image = UIImage(systemName: "chevron.down")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        
        button.contentHorizontalAlignment = .fill
        button.showsMenuAsPrimaryAction = true
        
        return button
    }
    
    private func configureLayout() {
        let stackView = UIStackView(
            arrangedSubviews: [
                countryOriginLabel,
                originButton,
                countryDestinationLabel,
                destinationButton
            ]
        )
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 32
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            
            originButton.heightAnchor.constraint(equalToConstant: 50),
            destinationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureMenus() {
        originButton.menu = makeOriginMenu()
        destinationButton.menu = makeDestinationMenu()
    }
    
    private func makeOriginMenu() -> UIMenu {
        let actions = viewModel.countries.map { country in
            UIAction(title: displayName(for: country)) { [weak self] _ in
                self?.selectOrigin(country)
            }
        }

        return UIMenu(children: actions)
    }
    
    private func makeDestinationMenu() -> UIMenu {
            let actions = viewModel.availableDestinationCountries.map { country in
                UIAction(title: displayName(for: country)) { [weak self] _ in
                    self?.selectDestination(country)
                }
            }

            return UIMenu(children: actions)
        }
    
    private func selectOrigin(_ country: Country) {
        viewModel.selectOrigin(country)
        
        originButton.configuration?.title = "\(country.flag.emoji) \(country.names.common)"
        print("Selected:", country.names.common)
        print("Emoji: [\(country.flag.emoji)]")
        
        if viewModel.selectedDestinationCountry == nil {
            destinationButton.configuration?.title = "Select country"
        }
        
        destinationButton.menu = makeDestinationMenu()
        destinationButton.isEnabled = true
    }
    
    private func selectDestination(_ country: Country) {
        viewModel.selectDestination(country)
        
        destinationButton.configuration?.title = "\(country.flag.emoji) \(country.names.common)"
        
        onDestinationSelected?(country)
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Unable to Load Countries",
            message: "Please try again.",
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )
        
        present(alert, animated: true)
    }
    
    private func displayName(for country: Country) -> String {
        if country.flag.emoji.isEmpty {
            return country.names.common
        }

        return "\(country.flag.emoji) \(country.names.common)"
    }
    
}
