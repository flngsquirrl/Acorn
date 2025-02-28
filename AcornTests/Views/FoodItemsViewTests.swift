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
    let dataSource = StubFoodItemsDataSource()
    let filterModel = StubFilterModel()

    func arrangeTestView() -> FoodItemsView {
        FoodItemsView(dataSource: dataSource, filterModel: filterModel)
    }

    @Test("There is a button for adding new item in the view")
    func addButtonPresent() throws {
        let view = arrangeTestView()

        let buttonText = try LocalizationTestUtils.getLocalizedString(for: "list.addItem.button")
        #expect(throws: Never.self) {
            try view.inspect().find(button: buttonText)
        }
    }

    @Test("All filter options are present in the view")
    func allOptionsPresent() throws {
        let view = arrangeTestView()

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

    @Test("Food items are displayed")
    func foodItemsAreDisplayed() throws {
        let testView = arrangeTestView()

        let views = try testView.inspect().findAll(FoodItemView.self)
        #expect(views.count == dataSource.items.count)
    }
}
