//
// FoodItemsView.swift
// Acorn
//
// Created by flngsquirrl on 12/02/2025.

import SwiftUI

struct FoodItemsView: View {
    @State private var items = FoodItem.examples

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) {
                    FoodItemView(item: $0)
                }
            }
            .listStyle(.plain)
            .navigationTitle("list.title")
        }
    }
}

#Preview("FoodItemsView: EN") {
    FoodItemsView()
}

#Preview("FoodItemsView: PL") {
    FoodItemsView()
        .environment(\.locale, Locale(identifier: "pl"))
}
