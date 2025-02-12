//
// FoodItem.swift
// Acorn
//
// Created by flngsquirrl on 11/02/2025.

import Foundation

class FoodItem {
    let id = UUID()
    var name: String
    var addedOn = Date()
    var isOpened: Bool
    var goodUntil: Date
    var quantity: Int

    init(name: String, isOpened: Bool = false, goodUntil: Date, quantity: Int = 1) {
        self.name = name
        self.isOpened = isOpened
        self.goodUntil = goodUntil
        self.quantity = quantity
    }

    /// Days untill the item expires.
    ///
    /// Negative if already expired.
    var daysTillExpires: Int {
        Date.now.getDayDifference(with: goodUntil)
    }

    var hasExpired: Bool {
        daysTillExpires < 0
    }
}

extension FoodItem: Identifiable {}
