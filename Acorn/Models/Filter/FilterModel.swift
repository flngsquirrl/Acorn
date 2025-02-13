//
// FilterModel.swift
// Acorn
//
// Created by flngsquirrl on 14/02/2025.
import Observation

@MainActor
@Observable
class FilterModel {
    var selected: Set<FilterOption>

    init(selected: Set<FilterOption> = .init(FilterOption.allCases)) {
        self.selected = selected
        processPostTurnOn()
    }

    func isSelected(_ option: FilterOption) -> Bool {
        selected.contains(option)
    }

    func toggle(_ option: FilterOption) {
        let shouldTurnOff = isSelected(option)

        if shouldTurnOff {
            turnOff(option)
        } else {
            turnOn(option)
        }
    }

    private func turnOff(_ option: FilterOption) {
        if option == .all {
            selected = []
        } else {
            selected.remove(option)
            selected.remove(.all)
        }
    }

    private func turnOn(_ option: FilterOption) {
        selected.insert(option)
        processPostTurnOn()
    }

    private func processPostTurnOn() {
        let maxCount = FilterOption.allCases.count

        guard selected.count != maxCount else {
            return
        }

        if isSelected(.all) || selected.count == maxCount - 1 {
            selected = .init(FilterOption.allCases)
        }
    }
}
