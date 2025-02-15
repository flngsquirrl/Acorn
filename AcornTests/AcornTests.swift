//
// AcornTests.swift
// Acorn
//
// Created by flngsquirrl on 14/02/2025.

@testable import Acorn
import Testing

@Suite
struct FilterModelTests {
    @Test("Selection after default init")
    func defaultInit() async throws {
        let model = await FilterModel()

        for option in FilterOption.allCases {
            #expect(await model.selected.contains(option))
        }
    }

    @Test("Selection after custom init", arguments: [
        ([FilterOption.all], FilterOption.allCases),
        ([FilterOption.good], [FilterOption.good]),
        ([FilterOption.bad], [FilterOption.bad]),
        ([FilterOption.expiring], [FilterOption.expiring]),
        ([FilterOption.good, FilterOption.bad], [FilterOption.good, FilterOption.bad]),
        ([FilterOption.good, FilterOption.expiring], [FilterOption.good, FilterOption.expiring]),
        ([FilterOption.bad, FilterOption.expiring], [FilterOption.bad, FilterOption.expiring]),
        ([FilterOption.good, FilterOption.bad, FilterOption.expiring], FilterOption.allCases)
    ])
    func customInit(initOptions: [FilterOption], expectedSelection: [FilterOption]) async throws {
        let model = await FilterModel(selected: Set(initOptions))

        await checkEqual(testOptions: model.selected, expectedOptions: expectedSelection)
    }

    @Test("Toggle single option", arguments: [
        (FilterOption.all, []),
        (FilterOption.good, [FilterOption.bad, FilterOption.expiring]),
        (FilterOption.bad, [FilterOption.good, FilterOption.expiring]),
        (FilterOption.expiring, [FilterOption.good, FilterOption.bad])
    ])
    func toggle(option: FilterOption, expectedSelection: [FilterOption]) async throws {
        let model = await FilterModel()

        await model.toggle(option)

        await checkEqual(testOptions: model.selected, expectedOptions: expectedSelection)
    }

    @Test("Toggle chain of options", arguments: [
        ([FilterOption.all, FilterOption.all], FilterOption.allCases),
        ([FilterOption.all, FilterOption.good], [FilterOption.good]),
        ([FilterOption.all, FilterOption.bad], [FilterOption.bad]),
        ([FilterOption.all, FilterOption.expiring], [FilterOption.expiring]),
        ([FilterOption.good, FilterOption.good], FilterOption.allCases),
        ([FilterOption.bad, FilterOption.bad], FilterOption.allCases),
        ([FilterOption.expiring, FilterOption.expiring], FilterOption.allCases),
        ([FilterOption.all, FilterOption.bad, FilterOption.good, FilterOption.expiring], FilterOption.allCases),
        ([FilterOption.good, FilterOption.bad], [FilterOption.expiring]),
        ([FilterOption.good, FilterOption.expiring], [FilterOption.bad]),
        ([FilterOption.bad, FilterOption.expiring], [FilterOption.good])
    ])
    func toggle(chain: [FilterOption], expectedSelection: [FilterOption]) async throws {
        let model = await FilterModel()

        for option in chain {
            await model.toggle(option)
        }

        await checkEqual(testOptions: model.selected, expectedOptions: expectedSelection)
    }

    @Test("Selection check", arguments: [
        ([FilterOption.all], FilterOption.all, true),
        ([FilterOption.all], FilterOption.good, true),
        ([FilterOption.all], FilterOption.bad, true),
        ([FilterOption.all], FilterOption.expiring, true),
        ([FilterOption.good], FilterOption.good, true),
        ([FilterOption.good], FilterOption.bad, false),
        ([FilterOption.good], FilterOption.expiring, false),
        ([FilterOption.good], FilterOption.all, false)
    ])
    func isSelected(selected: [FilterOption], testOption: FilterOption, expectedResult: Bool) async throws {
        let model = await FilterModel(selected: .init(selected))

        await #expect(model.isSelected(testOption) == expectedResult)
    }

    func checkEqual(testOptions: some Collection<FilterOption>, expectedOptions: some Collection<FilterOption>) {
        guard !expectedOptions.isEmpty else {
            #expect(testOptions.isEmpty)
            return
        }

        #expect(testOptions.count == expectedOptions.count)
        for option in expectedOptions {
            #expect(testOptions.contains(option))
        }
    }
}
