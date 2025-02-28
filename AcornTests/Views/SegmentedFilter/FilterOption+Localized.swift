//
// FilterOption+Localized.swift
// Acorn
//
// Created by flngsquirrl on 21/02/2025.

@testable import Acorn

extension FilterOption {
    var localizedText: String {
        get throws {
            try LocalizationTestUtils.getLocalizedString(for: rawValue)
        }
    }
}
