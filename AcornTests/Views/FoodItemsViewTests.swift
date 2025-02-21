//
// FoodItemsViewTests.swift
// Acorn
//
// Created by flngsquirrl on 21/02/2025.

@testable import Acorn
import Testing
import ViewInspector

@MainActor
struct FoodItemsViewTests {
    @Test("There is a button for adding new item in the view")
    func allOptionsPresent() throws {
        let view = FoodItemsView()

        let buttonText = try LocalizationTestUtils.getLocalizedString(for: "list.addItem.button")
        #expect(throws: Never.self) {
            try view.inspect().find(button: buttonText)
        }
    }
}
