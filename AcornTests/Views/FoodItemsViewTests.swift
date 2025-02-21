//
// FoodItemsViewTests.swift
// Acorn
//
// Created by flngsquirrl on 21/02/2025.

@testable import Acorn
import SwiftUI
import Testing
import ViewInspector

@MainActor
struct FoodItemsViewTests {
    @Test("There is a button for adding new item in the view")
    func addButtonPresent() throws {
        let view = FoodItemsView()

        let buttonText = try LocalizationTestUtils.getLocalizedString(for: "list.addItem.button")
        #expect(throws: Never.self) {
            try view.inspect().find(button: buttonText)
        }
    }

    @Test("All filter options are present in the view")
    func allOptionsPresent() throws {
        let view = FoodItemsView()

        let optionViews = try view.inspect().findAll(FilterOptionView.self)
        #expect(optionViews.count == FilterOption.allCases.count)

        let optionTexts = try FilterOption.allCases.map { try $0.localizedText }
        var optionTextsSet = Set(optionTexts)
        #expect(optionTexts.count == optionViews.count)

        for optionView in optionViews {
            let text = try optionView.find(ViewType.Text.self).string()
            optionTextsSet.remove(text)
        }
        #expect(optionTextsSet.isEmpty)
    }
}
