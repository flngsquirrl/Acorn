//
// ExampleFoodItemsDataSource.swift
// Acorn
//
// Created by flngsquirrl on 28/02/2025.
import Foundation
import Observation

@MainActor
@Observable
class ExampleFoodItemsDataSource: FoodItemsDataSource {
    var items: [FoodItem] = []

    func load() async {
        items = FoodItem.examples
    }

    func add(_ item: FoodItem) {
        items.append(item)
    }

    private func getIndex(of item: Item) -> Int? {
        items.firstIndex { $0.id == item.id }
    }

    func delete(_ item: FoodItem) {
        if let index = getIndex(of: item) {
            items.remove(at: index)
        }
    }

    func update(_ item: FoodItem) {
        if let index = getIndex(of: item) {
            items[index] = item
        }
    }

    func get(id: UUID) -> FoodItem? {
        items.first { $0.id == id }
    }
}
