//
// Date+DayDifference.swift
// Acorn
//
// Created by flngsquirrl on 11/02/2025.

import Foundation

extension Date {
    func getDayDifference(with date: Date) -> Int {
        let from = trimTime()
        let to = date.trimTime()

        let components = Calendar.current.dateComponents([.day], from: from, to: to)
        return components.day!
    }

    func trimTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)

        var newComponents = DateComponents()
        newComponents.year = components.year
        newComponents.month = components.month
        newComponents.day = components.day

        return Calendar.current.date(from: newComponents)!
    }
}
