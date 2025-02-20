//
// FilterModel.swift
// Acorn
//
// Created by flngsquirrl on 14/02/2025.
@MainActor
protocol FilterModel {
    var selectedOptions: Set<FilterOption> { get }

    func isSelected(_ option: FilterOption) -> Bool
    func toggle(_ option: FilterOption)
}
