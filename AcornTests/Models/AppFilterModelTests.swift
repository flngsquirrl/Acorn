//
// AppFilterModelTests.swift
// Acorn
//
// Created by flngsquirrl on 14/02/2025.

@testable import Acorn
import Testing

@MainActor
@Suite
struct AppFilterModelTests {
    @Test("Selected options are set correctly after default init")
    func selectedOptions_afterDefaultInit() async throws {
        let model = AppFilterModel()

        for option in FilterOption.allCases {
            #expect(model.selectedOptions.contains(option))
        }
    }

    @Test("Selected options are set correctly after custom init", arguments: [
        ([], []),
        ([FilterOption.all], FilterOption.allCases),
        ([FilterOption.good], [FilterOption.good]),
        ([FilterOption.bad], [FilterOption.bad]),
        ([FilterOption.expiring], [FilterOption.expiring]),
        ([FilterOption.good, FilterOption.bad], [FilterOption.good, FilterOption.bad]),
        ([FilterOption.good, FilterOption.expiring], [FilterOption.good, FilterOption.expiring]),
        ([FilterOption.bad, FilterOption.expiring], [FilterOption.bad, FilterOption.expiring]),
        ([FilterOption.good, FilterOption.bad, FilterOption.expiring], FilterOption.allCases)
    ])
    func selectedOptions_afterCustomInit(initOptions: [FilterOption], expected: [FilterOption]) async throws {
        let model = AppFilterModel(selectedOptions: Set(initOptions))

        checkEqual(test: model.selectedOptions, expected: expected)
    }

    @Test("Toggling a single option updates the selected options correctly", arguments: [
        // initial selection: full selection
        (FilterOption.all, FilterOption.allCases, []),
        (FilterOption.good, FilterOption.allCases, [FilterOption.bad, FilterOption.expiring]),
        (FilterOption.bad, FilterOption.allCases, [FilterOption.good, FilterOption.expiring]),
        (FilterOption.expiring, FilterOption.allCases, [FilterOption.good, FilterOption.bad]),
        // initial selection: none
        (FilterOption.all, [], FilterOption.allCases),
        (FilterOption.good, [], [FilterOption.good]),
        (FilterOption.bad, [], [FilterOption.bad]),
        (FilterOption.expiring, [], [FilterOption.expiring]),
        // deselecting from every single selection
        (FilterOption.good, [FilterOption.good], []),
        (FilterOption.bad, [FilterOption.bad], []),
        (FilterOption.expiring, [FilterOption.expiring], []),
        // every non-matching single combination
        (FilterOption.all, [FilterOption.good], FilterOption.allCases),
        (FilterOption.all, [FilterOption.bad], FilterOption.allCases),
        (FilterOption.all, [FilterOption.expiring], FilterOption.allCases),
        (FilterOption.good, [FilterOption.bad], [FilterOption.good, FilterOption.bad]),
        (FilterOption.good, [FilterOption.expiring], [FilterOption.good, FilterOption.expiring]),
        (FilterOption.bad, [FilterOption.good], [FilterOption.bad, FilterOption.good]),
        (FilterOption.bad, [FilterOption.expiring], [FilterOption.bad, FilterOption.expiring]),
        (FilterOption.expiring, [FilterOption.good], [FilterOption.expiring, FilterOption.good]),
        (FilterOption.expiring, [FilterOption.bad], [FilterOption.expiring, FilterOption.bad])
    ])
    func toggle(option: FilterOption, initOptions: [FilterOption], expected: [FilterOption]) async throws {
        let model = AppFilterModel(selectedOptions: .init(initOptions))
        try #require(isEqual(test: model.selectedOptions, expected: initOptions))

        model.toggle(option)

        checkEqual(test: model.selectedOptions, expected: expected)
    }

    @Test("Selection check returns correct value", arguments: [
        // initial selection: all
        (FilterOption.all, FilterOption.allCases, true),
        (FilterOption.good, FilterOption.allCases, true),
        (FilterOption.bad, FilterOption.allCases, true),
        (FilterOption.expiring, FilterOption.allCases, true),
        // initial selection: good
        (FilterOption.good, [FilterOption.good], true),
        (FilterOption.bad, [FilterOption.good], false),
        (FilterOption.expiring, [FilterOption.good], false),
        (FilterOption.all, [FilterOption.good], false),
        // initial selection: bad
        (FilterOption.good, [FilterOption.bad], false),
        (FilterOption.bad, [FilterOption.bad], true),
        (FilterOption.expiring, [FilterOption.bad], false),
        (FilterOption.all, [FilterOption.bad], false),
        // initial selection: expiring
        (FilterOption.good, [FilterOption.expiring], false),
        (FilterOption.bad, [FilterOption.expiring], false),
        (FilterOption.expiring, [FilterOption.expiring], true),
        (FilterOption.all, [FilterOption.expiring], false)
    ])
    func isSelected(option: FilterOption, initOptions: [FilterOption], expected: Bool) async throws {
        let model = AppFilterModel(selectedOptions: .init(initOptions))
        try #require(isEqual(test: initOptions, expected: model.selectedOptions))

        #expect(model.isSelected(option) == expected)
    }

    func checkEqual(test: some Collection<FilterOption>, expected: some Collection<FilterOption>) {
        guard !expected.isEmpty else {
            #expect(test.isEmpty)
            return
        }

        #expect(test.count == expected.count)
        for option in expected {
            #expect(test.contains(option))
        }
    }

    func isEqual(test: some Collection<FilterOption>, expected: some Collection<FilterOption>) -> Bool {
        guard test.count == expected.count else {
            return false
        }
        for option in expected where !test.contains(option) {
            return false
        }
        return true
    }
}
