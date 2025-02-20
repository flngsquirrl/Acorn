//
// TestFilterModel.swift
// Acorn
//
// Created by flngsquirrl on 20/02/2025.
@testable import Acorn

class MockFilterModel: FilterModel {
    var optionToggleCalls: [FilterOption: Int] = [:]

    var selectedOptions: Set<FilterOption> {
        .init()
    }

    func isSelected(_: FilterOption) -> Bool {
        false
    }

    func toggle(_ option: FilterOption) {
        optionToggleCalls[option, default: 0] += 1
    }
}
