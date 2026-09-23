//
//  CountryDetailViewController.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-23.
//

import Foundation
import UIKit

final class CountryDetailViewController: UIViewController {

    private let viewModel: CountryDetailViewModel

    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    init(viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.countryName
        view.backgroundColor = .systemBackground

        configureLayout()
        configureContent()
        loadFlag()
    }

    private func configureLayout() {
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(flagImageView)
        view.addSubview(infoLabel)

        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),
            flagImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            flagImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            flagImageView.heightAnchor.constraint(equalToConstant: 180),

            infoLabel.topAnchor.constraint(
                equalTo: flagImageView.bottomAnchor,
                constant: 24
            ),
            infoLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            infoLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            )
        ])
    }

    private func configureContent() {
        infoLabel.text = """
        Official name: \(viewModel.officialName)
        Capital: \(viewModel.capital)
        Region: \(viewModel.region)
        Population: \(viewModel.population)
        Currency: \(viewModel.currencies)
        Languages: \(viewModel.languages)
        """
    }

    private func loadFlag() {
        guard let url = viewModel.flagURL else {
            return
        }

        Task { [weak self] in
            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                guard let image = UIImage(data: data) else {
                    return
                }

                self?.flagImageView.image = image
            } catch {
                print("Failed to load flag:", error)
            }
        }
    }
}
