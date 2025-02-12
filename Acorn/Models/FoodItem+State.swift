//
// FoodItem+State.swift
// Acorn
//
// Created by flngsquirrl on 12/02/2025.

import Foundation

extension FoodItem {
    enum State: Equatable {
        case good(daysRemaining: Int)
        case bad(daysSinceExpired: Int)

        var isBad: Bool {
            if case .bad = self {
                return true
            }
            return false
        }
    }

    var state: State {
        if hasExpired {
            .bad(daysSinceExpired: abs(daysTillExpires))
        } else {
            .good(daysRemaining: daysTillExpires)
        }
    }
}
