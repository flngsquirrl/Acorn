//
// StubFoodItemsDataSource.swift
// Acorn
//
// Created by flngsquirrl on 28/02/2025.
@testable import Acorn
import Foundation

class StubFoodItemsDataSource: FoodItemsDataSource {
    var items: [FoodItem] = []

    init() {
        for i in 1 ... 3 {
            items.append(FoodItem.test(i))
        }
    }

    func load() async {}

    func add(_: Acorn.FoodItem) {}

    func delete(_: Acorn.FoodItem) {}

    func update(_: Acorn.FoodItem) {}

    func get(id _: UUID) -> Acorn.FoodItem? { nil }
}

extension FoodItem {
    static func test(_ index: Int) -> FoodItem {
        FoodItem(name: "Test item \(index)", goodUntil: .now)
    }
}
