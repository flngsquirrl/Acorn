//
// DataSource.swift
// Acorn
//
// Created by flngsquirrl on 28/02/2025.

@MainActor
protocol DataSource {
    associatedtype Item: Identifiable

    var items: [Item] { get }

    func load() async
    func add(_ item: Item)
    func delete(_ item: Item)
    func update(_ item: Item)
}
