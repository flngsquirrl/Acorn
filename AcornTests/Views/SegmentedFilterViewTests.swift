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
    @Test("Filter model selection is updated after an option is tapped",
          arguments: [
              (FilterOption.all, true),
              (FilterOption.all, false),
              (FilterOption.good, true),
              (FilterOption.good, false),
              (FilterOption.bad, true),
              (FilterOption.bad, false),
              (FilterOption.expiring, true),
              (FilterOption.expiring, false)
          ])
    func filterModelSelection_updatedAfterOptionTapped(option: FilterOption, isSelected: Bool) async throws {
        let model = try arrangeFilterModel(with: option, isSelected: isSelected)
        let view = arrangeTestView(with: model)

        try tap(option: option, in: view)

        #expect(model.isSelected(option) != isSelected)
    }

    func arrangeFilterModel(with option: FilterOption, isSelected: Bool) throws -> FilterModel {
        let selectedOptions: Set<FilterOption> = .init(isSelected ? [option] : [])
        let model = FilterModel(selectedOptions: selectedOptions)
        try #require(model.isSelected(option) == isSelected)
        return model
    }

    func arrangeTestView(with model: FilterModel) -> some View {
        SegmentedFilterView(filterModel: model)
    }

    func tap(option: FilterOption, in view: some View) throws {
        let optionText = try LocalizationTestUtils.getLocalizedString(for: option.rawValue)

        let optionViewOptional = try? view.inspect().find(FilterOptionView.self) {
            let optionView = try? $0.find(text: optionText)
            return optionView != nil
        }

        let optionView = try #require(optionViewOptional)
        try optionView.callOnTapGesture()
    }
}
