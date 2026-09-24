//
//  CountrySelectionViewController.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-23.
//

import Foundation
import UIKit

final class CountrySelectionViewController: UIViewController {

    private let viewModel: CountrySelectionViewModel

    var onCountrySelected: ((Country) -> Void)?

    private let tableView = UITableView(
        frame: .zero,
        style: .insetGrouped
    )

    private let activityIndicator = UIActivityIndicatorView(
        style: .large
    )

    init(viewModel: CountrySelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Countries"
        view.backgroundColor = .systemBackground

        configureTableView()
        configureActivityIndicator()
        loadCountries()
    }

    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }

    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
    }

    private func loadCountries() {
        activityIndicator.startAnimating()

        Task {
            do {
                try await viewModel.loadCountries()

                activityIndicator.stopAnimating()
                tableView.isHidden = false
                tableView.reloadData()
            } catch {
                activityIndicator.stopAnimating()
                showError()
            }
        }
    }

    private func showError() {
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
        guard !country.flag.emoji.isEmpty else {
            return country.names.common
        }

        return "\(country.flag.emoji) \(country.names.common)"
    }
}

extension CountrySelectionViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.countries.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = UITableViewCell(
            style: .default,
            reuseIdentifier: nil
        )

        let country = viewModel.countries[indexPath.row]

        cell.textLabel?.text = displayName(for: country)
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

extension CountrySelectionViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(
            at: indexPath,
            animated: true
        )

        let country = viewModel.countries[indexPath.row]

        onCountrySelected?(country)
    }
}
