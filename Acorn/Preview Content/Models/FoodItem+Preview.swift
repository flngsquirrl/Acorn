//
// FoodItem+Preview.swift
// Acorn
//
// Created by flngsquirrl on 11/02/2025.

import Foundation

@MainActor
extension FoodItem {
    static let expiringJogurt = FoodItem(
        name: "Jogurt",
        goodUntil: Calendar.current.date(byAdding: .day, value: 3, to: Date.now)!
    )

    static let goodTofu = FoodItem(
        name: "Tofu",
        goodUntil: Calendar.current.date(byAdding: .day, value: 15, to: Date.now)!
    )

    static let badMocarella = FoodItem(
        name: "Mocarella",
        goodUntil: Calendar.current.date(byAdding: .day, value: -5, to: Date.now)!
    )

    static let examples = [
        expiringJogurt, goodTofu, badMocarella
    ]
}
