//
//  CountrySelectionViewModel.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-23.
//

import Foundation
import UIKit

final class CountrySelectionViewModel{
    
    let countries = [
        "Sweden",
        "India"]
    
    private(set) var selectedCountry: String?
    
    func selectCountry(_ country: String) {
            selectedCountry = country
        }
}

