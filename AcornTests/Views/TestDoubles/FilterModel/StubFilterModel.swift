//
// StubFilterModel.swift
// Acorn
//
// Created by flngsquirrl on 20/02/2025.
@testable import Acorn

@MainActor
class StubFilterModel: FilterModel {
    var selectedOptions: Set<FilterOption> {
        .init()
    }

    func isSelected(_: FilterOption) -> Bool {
        false
    }

    func toggle(_: FilterOption) {}
}
