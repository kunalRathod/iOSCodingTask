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
        configureMenus()
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
               UIAction(title: country) { [weak self] _ in
                   self?.selectOrigin(country)
               }
           }

           return UIMenu(children: actions)
       }

       private func makeDestinationMenu() -> UIMenu {
           let countries = viewModel.countries.filter {
               $0 != viewModel.selectedCountry
           }

           let actions = countries.map { country in
               UIAction(title: country) { [weak self] _ in
                   self?.selectDestination(country)
               }
           }

           return UIMenu(children: actions)
       }

       private func selectOrigin(_ country: String) {
           viewModel.selectCountry(country)

           originButton.configuration?.title = country

           destinationButton.configuration?.title = "Select country"
           destinationButton.menu = makeDestinationMenu()
       }

       private func selectDestination(_ country: String) {
           destinationButton.configuration?.title = country
       }
}
