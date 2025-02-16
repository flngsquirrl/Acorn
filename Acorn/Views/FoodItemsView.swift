//
// FoodItemsView.swift
// Acorn
//
// Created by flngsquirrl on 12/02/2025.

import SwiftUI

struct FoodItemsView: View {
    @State private var items = FoodItem.examples
    @State private var filterModel: FilterModel = .init()

    var body: some View {
        NavigationStack {
            VStack {
                filter
                list
            }
            .navigationTitle("list.title")
        }
    }
}

extension FoodItemsView {
    var filter: some View {
        SegmentedFilterView(filterModel: filterModel)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background.secondary)
    }

    var list: some View {
        List {
            ForEach(items) {
                FoodItemView(item: $0)
            }
        }
        .listStyle(.plain)
    }
}

#Preview("FoodItemsView: EN") {
    FoodItemsView()
}

#Preview("FoodItemsView: PL") {
    FoodItemsView()
        .environment(\.locale, Locale(identifier: "pl"))
}
