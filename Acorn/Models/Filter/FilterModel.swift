//
// FilterModel.swift
// Acorn
//
// Created by flngsquirrl on 14/02/2025.
import Observation

@MainActor
@Observable
class FilterModel {
    var selectedOptions: Set<FilterOption>

    init(selectedOptions: Set<FilterOption> = .init(FilterOption.allCases)) {
        self.selectedOptions = selectedOptions
        processPostTurnOn()
    }

    func isSelected(_ option: FilterOption) -> Bool {
        selectedOptions.contains(option)
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
            selectedOptions = []
        } else {
            selectedOptions.remove(option)
            selectedOptions.remove(.all)
        }
    }

    private func turnOn(_ option: FilterOption) {
        selectedOptions.insert(option)
        processPostTurnOn()
    }

    private func processPostTurnOn() {
        let maxCount = FilterOption.allCases.count

        guard selectedOptions.count != maxCount else {
            return
        }

        if isSelected(.all) || selectedOptions.count == maxCount - 1 {
            selectedOptions = .init(FilterOption.allCases)
        }
    }
}
