//
// LocalizationUtils.swift
// Acorn
//
// Created by flngsquirrl on 19/02/2025.
import Foundation
import Testing

enum LocalizationTestUtils {
    static let localizationFileExtension = "lproj"
    static let defaultLocaleId = "en"

    static func getLocalizedString(for key: String, localeId: String = defaultLocaleId) throws -> String {
        let path = try #require(Bundle.main.path(forResource: localeId, ofType: localizationFileExtension))
        let bundle = try #require(Bundle(path: path))

        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}
