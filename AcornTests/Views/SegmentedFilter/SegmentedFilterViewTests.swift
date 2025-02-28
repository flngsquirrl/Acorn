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
        let optionText = try option.localizedText

        let optionViewOptional = try? view.inspect().find(FilterOptionView.self) {
            let textView = try? $0.find(text: optionText)
            return textView != nil
        }

        let optionView = try #require(optionViewOptional)
        return optionView
    }
}
