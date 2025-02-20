//
// SegmentedFilterViewTests.swift
// Acorn
//
// Created by flngsquirrl on 19/02/2025.

@testable import Acorn
import SwiftUI
import Testing
import ViewInspector

@MainActor
struct SegmentedFilterViewTests {
    typealias InspectableFilterOptionView = InspectableView<ViewType.View<FilterOptionView>>

    @Test("Filter model toggle is called after an option is tapped",
          arguments: FilterOption.allCases)
    func toggleFilterModel_afterOptionTapped(option: FilterOption) async throws {
        let model = try arrangeFilterModel()
        try #require(model.optionToggleCalls[option, default: 0] == 0)

        let view = arrangeTestView(with: model)

        try tap(option: option, in: view)

        #expect(model.optionToggleCalls[option] == 1)
    }

    func arrangeFilterModel() throws -> MockFilterModel {
        let model = MockFilterModel()
        return model
    }

    func arrangeTestView(with model: FilterModel) -> some View {
        SegmentedFilterView(filterModel: model)
    }

    func tap(option: FilterOption, in view: some View) throws {
        let optionView = try findOptionView(option: option, in: view)
        try optionView.callOnTapGesture()
    }

    func findOptionView(option: FilterOption, in view: some View) throws -> InspectableFilterOptionView {
        let optionText = try getText(for: option)

        let optionViewOptional = try? view.inspect().find(FilterOptionView.self) {
            let textView = try? $0.find(text: optionText)
            return textView != nil
        }

        let optionView = try #require(optionViewOptional)
        return optionView
    }

    func getText(for option: FilterOption) throws -> String {
        try LocalizationTestUtils.getLocalizedString(for: option.rawValue)
    }

    @Test("All filter options are present in the view")
    func allOptionsPresent() throws {
        let model = try arrangeFilterModel()
        let view = arrangeTestView(with: model)

        let optionViews = try view.inspect().findAll(FilterOptionView.self)
        #expect(optionViews.count == FilterOption.allCases.count)

        let optionTexts = try FilterOption.allCases.map { try getText(for: $0) }
        var optionTextsSet = Set(optionTexts)
        #expect(optionTexts.count == optionViews.count)

        for optionView in optionViews {
            let text = try optionView.anyView().anyView().text().string()
            optionTextsSet.remove(text)
        }
        #expect(optionTextsSet.isEmpty)
    }
}
